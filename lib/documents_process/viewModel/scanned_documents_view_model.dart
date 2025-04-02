import 'dart:io';
import 'package:flutter/material.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';
import 'package:salt_ware_tax/common/custom_loader.dart';
import 'package:salt_ware_tax/dashBoard/view/dash_board_screen.dart';
import 'package:salt_ware_tax/documents_process/repository/scanned_documents_repository.dart';

class ScannedDocumentsViewModel extends ChangeNotifier {
  final ScannedDocumentsRepository _scannedDocumentsRepository =
      ScannedDocumentsRepository();

  // Folders API with file upload
  Future<void> postDocuments(
    String description,
    String userId,
    List<File> files,
    BuildContext context,
  ) async {
    CustomLoader.showLoader(context);
    try {
      final response = await _scannedDocumentsRepository.postScannedDocuments(
        description,
        userId,
        files,
      );
      if (response != null &&
          response.data.isNotEmpty &&
          response.status == 200) {
        Navigator.pushAndRemoveUntil(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return const DashBoardScreen(); // The target screen
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
          (route) => false,
        );
        _showMessage("Documents uploaded successfully", context);
      } else {
        _showMessage("No data found or invalid response", context);
      }
    } catch (e) {
      _showMessage("Something went wrong..!", context);
    } finally {
      CustomLoader.hideLoader();
    }
  }

  // Message toast
  void _showMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }
}
