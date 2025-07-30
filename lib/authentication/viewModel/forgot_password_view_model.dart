import 'package:flutter/material.dart';
import 'package:salt_ware_tax/authentication/repository/forgot_password_repository.dart';
import 'package:salt_ware_tax/authentication/view/forgot_password_verification_screen.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';
import 'package:salt_ware_tax/common/custom_loader.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  final ForgotPasswordRepository _forgotPasswordRepository =
      ForgotPasswordRepository();

  //login
  Future<void> callForgotPasswordApi(
      String phoneNumber, BuildContext context) async {
    CustomLoader.showLoader(context);
    try {
      final response =
          await _forgotPasswordRepository.getVerificationOtp(phoneNumber);

      if (response.status == 200) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return ForgotPasswordVerificationScreen(
                  localOtp: response.data.first.otp!,
                  localPhoneNumber: phoneNumber);
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0); // Start from right to left
              const end = Offset.zero; // End at current position
              const curve = Curves.easeInOut; // Smooth transition
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(position: offsetAnimation, child: child);
            },
          ),
        );
      } else {
        _showErrorMessage("Please Register..!", context);
      }
    } finally {
      CustomLoader.hideLoader();
    }
  }

  //error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }
}
