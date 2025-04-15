import 'package:flutter/material.dart';
import 'package:salt_ware_tax/authentication/repository/new_user_sign_up_screen_repository.dart';
import 'package:salt_ware_tax/authentication/view/new_user_verification_screen.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';
import 'package:salt_ware_tax/common/custom_loader.dart';

class NewUserSignUpScreenViewModel extends ChangeNotifier {
  final NewUserSignUpScreenRepository _newUserSignUpScreenRepository =
      NewUserSignUpScreenRepository();

  //signup
  Future<void> callCheckUserApi(
      String userName,
      String password,
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String taxPayerId,
      BuildContext context) async {
    CustomLoader.showLoader(context);
    try {
      final response =
          await _newUserSignUpScreenRepository.checkUser(userName, phoneNumber);

      if (response.status == 200) {
        if (response.data.first.msg == 'You can go ahead') {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return NewUserVerificationScreen(
                  localUserName: userName,
                  localPassword: password,
                  localFirstName: firstName,
                  localLastName: lastName,
                  localEmail: email,
                  localPhoneNumber: phoneNumber,
                  localTaxPayerId: taxPayerId,
                );
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0); // Start from right to left
                const end = Offset.zero; // End at current position
                const curve = Curves.easeInOut; // Smooth transition
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(position: offsetAnimation, child: child);
              },
            ),
          );
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

  //error message toast
  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }
}
