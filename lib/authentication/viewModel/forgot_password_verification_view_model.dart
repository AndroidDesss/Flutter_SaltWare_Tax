import 'package:flutter/material.dart';
import 'package:salt_ware_tax/authentication/repository/forgot_password_verification_repository.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';
import 'package:salt_ware_tax/common/custom_loader.dart';

class ForgotPasswordVerificationViewModel extends ChangeNotifier {
  final ForgotPasswordVerificationRepository
      _forgotPasswordVerificationRepository =
      ForgotPasswordVerificationRepository();

  String localOtp = '';

  //forgot password
  Future<void> callReSendForgotPasswordVerificationApi(
      String phoneNumber, BuildContext context) async {
    CustomLoader.showLoader(context);
    try {
      final response = await _forgotPasswordVerificationRepository
          .getResendVerificationOtp(phoneNumber);

      if (response.status == 200) {
        _setLocalOtp(response.data.first.otp);
      }
    } catch (e) {
      _showErrorMessage("Credentials Wrong..!", context);
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
