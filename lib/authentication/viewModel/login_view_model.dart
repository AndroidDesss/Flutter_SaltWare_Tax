import 'package:flutter/material.dart';
import 'package:salt_ware_tax/authentication/repository/login_repository.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';
import 'package:salt_ware_tax/common/custom_loader.dart';
import 'package:salt_ware_tax/common/shared_pref.dart';
import 'package:salt_ware_tax/dashBoard/view/dash_board_screen.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginRepository _loginRepository = LoginRepository();

  //login
  Future<void> callLoginApi(
      String phoneNumber, String password, BuildContext context) async {
    CustomLoader.showLoader(context);
    try {
      final response = await _loginRepository.login(phoneNumber, password);

      if (response.status == 200) {
        await SharedPrefsHelper.init();
        await SharedPrefsHelper.setString('user_id', response.data.first.id);
        await SharedPrefsHelper.setString(
            'email_id', response.data.first.email);
        await SharedPrefsHelper.setString('loginType', 'normal');
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return const DashBoardScreen();
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(position: offsetAnimation, child: child);
            },
          ),
          (route) => false,
        );
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

}
