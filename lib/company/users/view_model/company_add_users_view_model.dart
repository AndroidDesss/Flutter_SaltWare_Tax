import 'package:flutter/material.dart';
import 'package:salt_ware_tax/authentication/repository/new_user_sign_up_screen_repository.dart';
import 'package:salt_ware_tax/authentication/repository/new_user_verification_repository.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';
import 'package:salt_ware_tax/common/custom_loader.dart';

class CompanyAddUsersViewModel extends ChangeNotifier {
  final NewUserSignUpScreenRepository _newUserSignUpScreenRepository =
      NewUserSignUpScreenRepository();

  final NewUserVerificationRepository _newUserVerificationRepository =
      NewUserVerificationRepository();

  //signup
  Future<void> callCheckUserApi(
      String userName,
      String password,
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String companyName,
      BuildContext context) async {
    CustomLoader.showLoader(context);
    try {
      final response = await _newUserSignUpScreenRepository.checkUser(
          userName, phoneNumber, 'Assigned_by_company', companyName);

      if (response.status == 200) {
        if (response.data.first.msg == 'You can go ahead') {
          callSignUpApi(userName, password, firstName, lastName, email,
              phoneNumber, companyName, 'Assigned_by_company', context);
        } else {
          _showErrorMessage("Already Registered..!", context);
        }
      }
    } catch (e) {
      _showErrorMessage("Already Registered..!", context);
    } finally {
      CustomLoader.hideLoader();
    }
  }

  Future<void> callSignUpApi(
      String userName,
      String password,
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String companyName,
      String loginType,
      BuildContext context) async {
    try {
      final response = await _newUserVerificationRepository.verifyNewUser(
          userName,
          password,
          firstName,
          lastName,
          email,
          phoneNumber,
          companyName,
          loginType);
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
