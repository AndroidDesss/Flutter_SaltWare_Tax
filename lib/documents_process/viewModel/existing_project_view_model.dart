import 'package:flutter/material.dart';
import 'package:salt_ware_tax/common/custom_loader.dart';
import 'package:salt_ware_tax/documents_process/model/existing_project_model.dart';
import 'package:salt_ware_tax/documents_process/repository/existing_project_repository.dart';

class ExistingProjectViewModel extends ChangeNotifier {
  final ExistingProjectRepository _existingProjectRepository =
      ExistingProjectRepository();

  bool _noFolders = false;
  bool get noFolders => _noFolders;

  List<ExistingProjectResponse> _foldersList = [];
  List<ExistingProjectResponse> get foldersList => _foldersList;

  List<ExistingProjectResponse> _originalFoldersList = [];

  List<ExistingProjectResponse> _originalFolders = [];

  // Folders API
  Future<void> fetchFoldersList(String userId, BuildContext context) async {
    CustomLoader.showLoader(context);
    _setNoFolders(false);

    try {
      final response = await _existingProjectRepository.getProjectList(userId);
      if (response.data.isNotEmpty && response.status == 200) {
        List<ExistingProjectResponse> filteredFoldersList = response.data;
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
        a.projectName.toLowerCase().compareTo(b.projectName.toLowerCase()));
    notifyListeners();
  }

  // No folders
  void _setNoFolders(bool value) {
    _noFolders = value;
    notifyListeners();
  }

  //search Folders
  void searchFolders(String query) {
    if (query.isEmpty) {
      _foldersList = List.from(_originalFolders);
    } else {
      _foldersList = _originalFolders.where((folders) {
        return folders.projectName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
