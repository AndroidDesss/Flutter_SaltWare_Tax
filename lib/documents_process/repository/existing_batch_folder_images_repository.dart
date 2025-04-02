import 'package:salt_ware_tax/documents_process/model/existing_batch_folder_images_model.dart';
import 'package:salt_ware_tax/documents_process/model/ocr_model.dart';
import 'package:salt_ware_tax/documents_process/model/pdf_model.dart';
import 'package:salt_ware_tax/network/api_response.dart';
import 'package:salt_ware_tax/network/network_api_service.dart';

class ExistingBatchFolderImagesRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<CommonApiResponse<ExistingBatchFolderImagesResponse>> getBatchImages(
      String batchId) async {
    Map<String, String> body = {
      'table': 'accounts_file',
      'batch_id': batchId,
    };
    try {
      final response = await _apiService.postResponse('read', body);

      if (response != null) {
        return CommonApiResponse.fromJson(response,
            (item) => ExistingBatchFolderImagesResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonApiResponse<PdfResponse>> getBatchPdf(String batchId) async {
    Map<String, String> body = {
      'table': 'Pdf_Bundels',
      'batch_id': batchId,
    };
    try {
      final response = await _apiService.postResponse('read', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => PdfResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonApiResponse<OcrResponse>> sendDataToOcr(
      String email, String categoryName, String pdfUrl) async {
    Map<String, String> body = {
      'email': email,
      'category_name': categoryName,
      'url': pdfUrl,
    };
    try {
      final response =
          await _apiService.postOcrResponse('upload_pdf_url/', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => OcrResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }
}
