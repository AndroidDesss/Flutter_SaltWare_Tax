import 'package:flutter/material.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';
import 'package:salt_ware_tax/common/custom_loader.dart';
import 'package:salt_ware_tax/company/users/repository/users_repository.dart';
import 'package:salt_ware_tax/authentication/model/login_model.dart';

class CompanyUsersViewModel extends ChangeNotifier {
  final UsersRepository _usersRepository = UsersRepository();

  bool _noUsers = false;
  bool get noUsers => _noUsers;

  List<LoginResponse> _usersList = [];
  List<LoginResponse> get usersList => _usersList;

  List<LoginResponse> _originalUsersList = [];

  List<LoginResponse> _originalUsers = [];

  // Folders API
  Future<void> fetchCompanyBasedUsersList(
      String companyName, BuildContext context) async {
    CustomLoader.showLoader(context);
    _setNoProjects(false);

    try {
      final response = await _usersRepository.getCompanyBasedUsers(companyName);
      if (response.data.isNotEmpty && response.status == 200) {
        List<LoginResponse> filteredFoldersList = response.data;
        if (filteredFoldersList.isNotEmpty) {
          _usersList = filteredFoldersList;
          _originalUsersList = List.from(filteredFoldersList);
          _originalUsers = List.from(filteredFoldersList);
        } else {
          _usersList = [];
          _originalUsersList = [];
          _originalUsers = [];
          _setNoProjects(true);
        }
      } else {
        _usersList = [];
        _originalUsersList = [];
        _originalUsers = [];
        _setNoProjects(true);
      }
    } catch (e) {
      _usersList = [];
      _originalUsersList = [];
      _originalUsers = [];
      _setNoProjects(true);
      _showErrorMessage("Something went wrong..!", context);
      CustomLoader.hideLoader();
    } finally {
      CustomLoader.hideLoader();
      notifyListeners();
    }
  }

  // Reset the folders list to the original order
  void resetProjectsList() {
    _usersList = List.from(_originalUsersList);
    notifyListeners();
  }

  // Sort the folders list alphabetically by description
  void sortProjectsList() {
    _usersList.sort((a, b) =>
        a.firstName.toLowerCase().compareTo(b.firstName.toLowerCase()));
    notifyListeners();
  }

  // No folders
  void _setNoProjects(bool value) {
    _noUsers = value;
    notifyListeners();
  }

  // Error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }

  //search Folders
  void searchProjects(String query) {
    if (query.isEmpty) {
      _usersList = List.from(_originalUsers);
    } else {
      _usersList = _originalUsers.where((folders) {
        return folders.firstName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
