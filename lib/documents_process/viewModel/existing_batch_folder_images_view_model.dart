import 'package:flutter/material.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';
import 'package:salt_ware_tax/common/custom_loader.dart';
import 'package:salt_ware_tax/common/shared_pref.dart';
import 'package:salt_ware_tax/documents_process/model/existing_batch_folder_images_model.dart';
import 'package:salt_ware_tax/documents_process/model/pdf_model.dart';
import 'package:salt_ware_tax/documents_process/repository/existing_batch_folder_images_repository.dart';

class ExistingBatchFolderImagesViewModel extends ChangeNotifier {
  final ExistingBatchFolderImagesRepository
      _existingBatchFolderImagesRepository =
      ExistingBatchFolderImagesRepository();

  bool _noImages = false;
  bool get noImages => _noImages;

  List<ExistingBatchFolderImagesResponse> _imagesList = [];
  List<ExistingBatchFolderImagesResponse> get imagesList => _imagesList;

  List<PdfResponse> _pdfList = [];
  List<PdfResponse> get pdfList => _pdfList;

  // Images API
  Future<void> fetchBatchImagesList(
      String batchId, String batchName, BuildContext context) async {
    Future.delayed(Duration.zero, () {
      CustomLoader.showLoader(context);
    });
    _setNoImages(false);

    try {
      final response =
          await _existingBatchFolderImagesRepository.getBatchImages(batchId);

      if (response.status == 200 && response.data.isNotEmpty) {
        List<ExistingBatchFolderImagesResponse> filteredImagesList =
            response.data;

        if (filteredImagesList.isNotEmpty) {
          CustomLoader.hideLoader();
          _imagesList = filteredImagesList;
          notifyListeners();
          await fetchBatchPdf(
              batchId, batchName, context); // Fetch PDFs after images
        } else {
          CustomLoader.hideLoader();
          _imagesList = [];
          _setNoImages(true);
        }
      } else {
        CustomLoader.hideLoader();
        _imagesList = [];
        _setNoImages(true);
      }
    } catch (e) {
      CustomLoader.hideLoader();
      _imagesList = [];
      _setNoImages(true);
      _showErrorMessage("Something went wrong..!", context);
    } finally {
      CustomLoader.hideLoader();
      notifyListeners();
    }
  }

  Future<void> fetchBatchPdf(
      String batchId, String batchName, BuildContext context) async {
    try {
      final response =
          await _existingBatchFolderImagesRepository.getBatchPdf(batchId);
      if (response.data.isNotEmpty && response.status == 200) {
        _pdfList = response.data;
        await SharedPrefsHelper.init();
        String emailId = SharedPrefsHelper.getString('email_id')!;

        await sendPdfToOcr(
            emailId, batchName, response.data.first.pdfPath, context);
      } else {
        _pdfList = [];
      }
    } catch (e) {
      _pdfList = [];
      _showErrorMessage("Failed to fetch pdf..!", context);
    }
  }

  Future<void> sendPdfToOcr(String email, String batchName, String pdfUrl,
      BuildContext context) async {
    try {
      final response = await _existingBatchFolderImagesRepository.sendDataToOcr(
          email, batchName, pdfUrl);
      if (response.data.isNotEmpty && response.status == 200) {
        _showErrorMessage("Document Processed To Ocr..!", context);
      }
    } catch (e) {
      _showErrorMessage("Failed to send pdf..!", context);
    }
  }

  // No Images
  void _setNoImages(bool value) {
    _noImages = value;
    notifyListeners();
  }

  // Error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }
}
