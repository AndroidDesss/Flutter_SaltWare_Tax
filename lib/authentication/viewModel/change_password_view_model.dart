import 'package:flutter/material.dart';
import 'package:salt_ware_tax/authentication/repository/change_password_repository.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';
import 'package:salt_ware_tax/common/custom_loader.dart';

class ChangePasswordViewModel extends ChangeNotifier {
  final ChangePasswordRepository _changePasswordRepository =
      ChangePasswordRepository();

  //login
  Future<void> callChangePasswordApi(
      String phoneNumber, String password, BuildContext context) async {
    CustomLoader.showLoader(context);
    try {
      final response =
          await _changePasswordRepository.changePassword(phoneNumber, password);

      if (response.status == 200) {
        _showErrorMessage(response.data.first.message!, context);
        Navigator.pop(context);
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
