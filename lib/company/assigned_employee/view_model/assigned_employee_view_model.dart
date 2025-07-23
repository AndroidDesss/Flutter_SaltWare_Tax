import 'package:flutter/material.dart';
import 'package:salt_ware_tax/authentication/model/login_model.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';
import 'package:salt_ware_tax/common/custom_loader.dart';
import 'package:salt_ware_tax/company/assigned_employee/model/assigned_employees_model.dart';
import 'package:salt_ware_tax/company/assigned_employee/repository/assigned_employees_repository.dart';
import 'package:salt_ware_tax/company/project/model/project_model.dart';
import 'package:salt_ware_tax/company/users/repository/users_repository.dart';

class AssignedEmployeeViewModel extends ChangeNotifier {
  final AssignedEmployeesRepository _assignedEmployeesRepository =
      AssignedEmployeesRepository();

  final UsersRepository _usersRepository = UsersRepository();

  bool _noUsers = false;
  bool get noUsers => _noUsers;

  bool _noAllUsers = false;
  bool get noAllUsers => _noAllUsers;

  List<AssignedEmployeesResponse> _usersList = [];
  List<AssignedEmployeesResponse> get usersList => _usersList;

  List<LoginResponse> _usersAllList = [];
  List<LoginResponse> get usersAllList => _usersAllList;

  List<AssignedEmployeesResponse> _originalUsersList = [];

  List<AssignedEmployeesResponse> _originalUsers = [];

  List<String> _assignedUserIds = [];
  List<String> get assignedUserIds => _assignedUserIds;

  // Folders API
  Future<void> fetchCompanyBasedUsersList(
      String projectId, BuildContext context) async {
    CustomLoader.showLoader(context);
    _setNoUsers(false);
    try {
      final response = await _assignedEmployeesRepository
          .getAssignedEmployeeBasedProjects(projectId);
      if (response.data.isNotEmpty && response.status == 200) {
        CustomLoader.hideLoader();
        List<AssignedEmployeesResponse> filteredFoldersList = response.data;
        if (filteredFoldersList.isNotEmpty) {
          _usersList = filteredFoldersList;
          _originalUsersList = List.from(filteredFoldersList);
          _originalUsers = List.from(filteredFoldersList);
          _assignedUserIds = _usersList.map((user) => user.id).toList();
        } else {
          _usersList = [];
          _originalUsersList = [];
          _originalUsers = [];
          _assignedUserIds = [];
          _setNoUsers(true);
        }
      } else {
        _usersList = [];
        _originalUsersList = [];
        _originalUsers = [];
        _assignedUserIds = [];
        _setNoUsers(true);
        CustomLoader.hideLoader();
      }
    } catch (e) {
      _usersList = [];
      _originalUsersList = [];
      _originalUsers = [];
      _setNoUsers(true);
      _showErrorMessage("Something went wrong..!", context);
    } finally {
      CustomLoader.hideLoader();
      notifyListeners();
    }
  }

  // Reset the folders list to the original order
  void resetUsersList() {
    _usersList = List.from(_originalUsersList);
    notifyListeners();
  }

  // Sort the folders list alphabetically by description
  void sortUsersList() {
    _usersList.sort((a, b) =>
        a.firstName.toLowerCase().compareTo(b.firstName.toLowerCase()));
    notifyListeners();
  }

  // No folders
  void _setNoUsers(bool value) {
    _noUsers = value;
    notifyListeners();
  }

  // Error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }

  //search Folders
  void searchUsers(String query) {
    if (query.isEmpty) {
      _usersList = List.from(_originalUsers);
    } else {
      _usersList = _originalUsers.where((folders) {
        return folders.firstName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  void updateAssignedUserIds(List<String> newIds) {
    _assignedUserIds = List<String>.from(newIds);
    notifyListeners();
  }

  Future<List<LoginResponse>> fetchAllUsersList(
      String companyName, BuildContext context) async {
    CustomLoader.showLoader(context);
    _setNoAllUsers(false);

    try {
      final response = await _usersRepository.getCompanyBasedUsers(companyName);
      if (response.data.isNotEmpty && response.status == 200) {
        List<LoginResponse> filteredFoldersList = response.data;
        if (filteredFoldersList.isNotEmpty) {
          _usersAllList = filteredFoldersList;
          return filteredFoldersList; // return users list
        } else {
          _usersAllList = [];
          _setNoAllUsers(true);
          return [];
        }
      } else {
        _usersAllList = [];
        _setNoAllUsers(true);
        return [];
      }
    } catch (e) {
      _usersAllList = [];
      _setNoAllUsers(true);
      _showErrorMessage("Something went wrong..!", context);
      return [];
    } finally {
      CustomLoader.hideLoader();
      notifyListeners();
    }
  }

  void _setNoAllUsers(bool value) {
    _noAllUsers = value;
    notifyListeners();
  }

  Future<bool> updateUserList(
      String projectId, String userIds, BuildContext context) async {
    CustomLoader.showLoader(context);
    try {
      final response = await _assignedEmployeesRepository
          .uploadEmployeeBasedOnProjects(projectId, userIds);
      if (response.status == 200 && response.data.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      _showErrorMessage("Something went wrong..!", context);
      return false;
    } finally {
      CustomLoader.hideLoader();
      notifyListeners();
    }
  }
}
