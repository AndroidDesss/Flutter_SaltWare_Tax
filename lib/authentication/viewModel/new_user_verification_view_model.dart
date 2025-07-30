import 'package:flutter/material.dart';
import 'package:salt_ware_tax/authentication/repository/new_user_verification_repository.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';
import 'package:salt_ware_tax/common/custom_loader.dart';

class NewUserVerificationViewModel extends ChangeNotifier {
  final NewUserVerificationRepository _newUserVerificationRepository =
      NewUserVerificationRepository();

  String localOtp = '';

  //forgot password
  Future<void> callVerificationOtpApi(
      String phoneNumber, BuildContext context) async {
    CustomLoader.showLoader(context);
    try {
      final response =
          await _newUserVerificationRepository.getVerificationOtp(phoneNumber);

      if (response.status == 200) {
        _setLocalOtp(response.data.first.otp!);
      } else {
        _showErrorMessage("Please Check your PhoneNumber..!", context);
      }
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
    CustomLoader.showLoader(context);
    try {
      final response = await _newUserVerificationRepository.verifyNewUser(
        userName,
        password,
        email,
        phoneNumber,
        loginType,
        firstName,
        lastName,
        companyName,
      );
      if (response.status == 200) {
        Navigator.pop(context);
        _showErrorMessage("Thanks for signing up..!", context);
      }
    } catch (e) {
      _showErrorMessage("Try after sometime..!", context);
    } finally {
      CustomLoader.hideLoader();
    }
  }

  //error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }

  void _setLocalOtp(String otp) {
    localOtp = otp;
    notifyListeners();
  }
}
