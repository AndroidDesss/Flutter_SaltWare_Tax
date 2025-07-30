import 'package:flutter/material.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';
import 'package:salt_ware_tax/common/custom_loader.dart';
import 'package:salt_ware_tax/company/users/repository/users_repository.dart';

class CompanyAddUsersViewModel extends ChangeNotifier {
  final UsersRepository _usersRepository = UsersRepository();

  Future<void> callSignUpApi(
      String userName,
      String password,
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String userId,
      BuildContext context) async {
    CustomLoader.showLoader(context);
    try {
      final response = await _usersRepository.addNewUser(
          userName, email, phoneNumber, password, firstName, lastName, userId);
      if (response.status == 200) {
        Navigator.pop(context);
        _showErrorMessage("Thanks for signing up..!", context);
      }
    } catch (e) {
      _showErrorMessage("Wrong..!", context);
    } finally {
      CustomLoader.hideLoader();
    }
  }

  //error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }
}
