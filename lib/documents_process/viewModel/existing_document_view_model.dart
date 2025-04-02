import 'package:flutter/material.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';
import 'package:salt_ware_tax/common/custom_loader.dart';
import 'package:salt_ware_tax/documents_process/model/existing_document_model.dart';
import 'package:salt_ware_tax/documents_process/repository/existing_document_repository.dart';

class ExistingDocumentViewModel extends ChangeNotifier {
  final ExistingDocumentRepository _existingDocumentRepository =
      ExistingDocumentRepository();

  bool _noFolders = false;
  bool get noFolders => _noFolders;

  List<ExistingDocumentResponse> _foldersList = [];
  List<ExistingDocumentResponse> get foldersList => _foldersList;

  List<ExistingDocumentResponse> _originalFoldersList = [];

  List<ExistingDocumentResponse> _originalFolders = [];

  // Folders API
  Future<void> fetchFoldersList(String userId, BuildContext context) async {
    CustomLoader.showLoader(context);
    _setNoFolders(false);

    try {
      final response = await _existingDocumentRepository.getFoldersList(userId);
      if (response.data.isNotEmpty && response.status == 200) {
        List<ExistingDocumentResponse> filteredFoldersList = response.data;
        if (filteredFoldersList.isNotEmpty) {
          _foldersList = filteredFoldersList;
          _originalFoldersList = List.from(filteredFoldersList);
          _originalFolders = List.from(filteredFoldersList);
        } else {
          _foldersList = [];
          _originalFoldersList = [];
          _originalFolders = [];
          _setNoFolders(true);
        }
      } else {
        _foldersList = [];
        _originalFoldersList = [];
        _originalFolders = [];
        _setNoFolders(true);
      }
    } catch (e) {
      _foldersList = [];
      _originalFoldersList = [];
      _originalFolders = [];
      _setNoFolders(true);
      _showErrorMessage("Something went wrong..!", context);
    } finally {
      CustomLoader.hideLoader();
      notifyListeners();
    }
  }

  // Reset the folders list to the original order
  void resetFoldersList() {
    _foldersList = List.from(_originalFoldersList);
    notifyListeners();
  }

  // Sort the folders list alphabetically by description
  void sortFoldersList() {
    _foldersList.sort((a, b) =>
        a.description.toLowerCase().compareTo(b.description.toLowerCase()));
    notifyListeners();
  }

  // No folders
  void _setNoFolders(bool value) {
    _noFolders = value;
    notifyListeners();
  }

  // Error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }

  //search Folders
  void searchFolders(String query) {
    if (query.isEmpty) {
      _foldersList = List.from(_originalFolders);
    } else {
      _foldersList = _originalFolders.where((folders) {
        return folders.description.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
