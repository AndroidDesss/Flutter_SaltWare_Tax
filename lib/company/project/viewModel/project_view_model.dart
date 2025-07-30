import 'package:flutter/material.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';
import 'package:salt_ware_tax/common/custom_loader.dart';
import 'package:salt_ware_tax/company/project/model/project_model.dart';
import 'package:salt_ware_tax/company/project/repository/project_repository.dart';

class ProjectViewModel extends ChangeNotifier {
  final ProjectRepository _projectRepository = ProjectRepository();

  bool _noProjects = false;
  bool get noProjects => _noProjects;

  List<ProjectResponse> _projectsList = [];
  List<ProjectResponse> get foldersList => _projectsList;

  List<ProjectResponse> _originalProjectsList = [];

  List<ProjectResponse> _originalProjects = [];

  // Folders API
  Future<void> fetchProjectsList(String userId, BuildContext context) async {
    CustomLoader.showLoader(context);
    _setNoProjects(false);

    try {
      final response = await _projectRepository.getProjectDetails(userId);
      if (response.data.isNotEmpty && response.status == 200) {
        List<ProjectResponse> filteredFoldersList = response.data;
        if (filteredFoldersList.isNotEmpty) {
          _projectsList = filteredFoldersList;
          _originalProjectsList = List.from(filteredFoldersList);
          _originalProjects = List.from(filteredFoldersList);
        } else {
          _projectsList = [];
          _originalProjectsList = [];
          _originalProjects = [];
          _setNoProjects(true);
        }
      } else {
        _projectsList = [];
        _originalProjectsList = [];
        _originalProjects = [];
        _setNoProjects(true);
      }
    } catch (e) {
      _projectsList = [];
      _originalProjectsList = [];
      _originalProjects = [];
      _setNoProjects(true);
    } finally {
      CustomLoader.hideLoader();
      notifyListeners();
    }
  }

  // Reset the folders list to the original order
  void resetProjectsList() {
    _projectsList = List.from(_originalProjectsList);
    notifyListeners();
  }

  // Sort the folders list alphabetically by description
  void sortProjectsList() {
    _projectsList.sort((a, b) =>
        a.projectName.toLowerCase().compareTo(b.projectName.toLowerCase()));
    notifyListeners();
  }

  // No folders
  void _setNoProjects(bool value) {
    _noProjects = value;
    notifyListeners();
  }

  // Error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }

  //search Folders
  void searchProjects(String query) {
    if (query.isEmpty) {
      _projectsList = List.from(_originalProjects);
    } else {
      _projectsList = _originalProjects.where((folders) {
        return folders.projectName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  Future<bool> addProjects(
    String projectName,
    String userId,
    BuildContext context,
  ) async {
    try {
      CustomLoader.showLoader(context);
      final response =
          await _projectRepository.createProject(projectName, userId);

      if (response.status == 200) {
        _showErrorMessage("Project Created..!", context);
        return true;
      } else {
        _showErrorMessage(response.data.first.errmsg!, context);
      }
    } catch (e) {
      CustomLoader.hideLoader();
      return false;
    } finally {
      CustomLoader.hideLoader();
      notifyListeners();
    }
    return false;
  }
}
