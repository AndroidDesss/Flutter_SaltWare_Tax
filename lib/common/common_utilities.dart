import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:intl/intl.dart';

class CommonUtilities {
  static void showToast(
    BuildContext context, {
    required String message,
  }) {
    toastification.show(
      context: context,
      backgroundColor: Colors.black,
      title: Text(
        message,
        style: const TextStyle(
            fontSize: 14.0, color: Colors.white, fontFamily: 'PoppinsSemiBold'),
      ),
      autoCloseDuration: const Duration(seconds: 3),
      showIcon: false,
      showProgressBar: false,
      closeButtonShowType: CloseButtonShowType.none,
      alignment: Alignment.bottomCenter, // Set the toast position here
    );
  }

  static String getCurrentDate() {
    return DateFormat("MM-dd-yyyy").format(DateTime.now());
  }
}
