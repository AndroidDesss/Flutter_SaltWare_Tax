import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salt_ware_tax/authentication/view/change_password.dart';
import 'package:salt_ware_tax/authentication/viewModel/forgot_password_verification_view_model.dart';
import 'package:salt_ware_tax/common/AppStrings.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';

class ForgotPasswordVerificationScreen extends StatefulWidget {
  final String localOtp;
  final String localRegion;
  final String localPhoneNumber;

  const ForgotPasswordVerificationScreen(
      {super.key,
      required this.localOtp,
      required this.localRegion,
      required this.localPhoneNumber});

  @override
  ForgotPasswordVerificationScreenState createState() =>
      ForgotPasswordVerificationScreenState();
}

class ForgotPasswordVerificationScreenState
    extends State<ForgotPasswordVerificationScreen> {
  final ForgotPasswordVerificationViewModel
      forgotPasswordVerificationViewModel =
      ForgotPasswordVerificationViewModel();

  final _formKey = GlobalKey<FormState>();

  bool _isVerifyPressed = false;

  final _otpController1 = TextEditingController();
  final _otpController2 = TextEditingController();
  final _otpController3 = TextEditingController();
  final _otpController4 = TextEditingController();
  final _otpController5 = TextEditingController();
  final _otpController6 = TextEditingController();

  final _otpControllerFocusNode1 = FocusNode();
  final _otpControllerFocusNode2 = FocusNode();
  final _otpControllerFocusNode3 = FocusNode();
  final _otpControllerFocusNode4 = FocusNode();
  final _otpControllerFocusNode5 = FocusNode();
  final _otpControllerFocusNode6 = FocusNode();

  @override
  void initState() {
    super.initState();
    forgotPasswordVerificationViewModel.localOtp = widget.localOtp;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPasswordVerificationViewModel>(
      create: (BuildContext context) => forgotPasswordVerificationViewModel,
      child: SafeArea(
        child: Scaffold(
          body: Consumer<ForgotPasswordVerificationViewModel>(
              builder: (context, viewModel, child) {
            return Stack(children: [
              Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background_gradient.jpg'),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            'assets/icons/app_logo.png',
                            width: 90,
                            height: 90,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 35),
                          const Text(
                            AppStrings.verification,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'PoppinsSemiBold',
                              fontSize: 28,
                            ),
                          ),
                          const SizedBox(height: 5),
                          const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Text(
                              AppStrings.verificationContentText,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'PoppinsRegular',
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            AppStrings.otp,
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'PoppinsSemiBold',
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  buildOTPField(_otpController1,
                                      _otpControllerFocusNode1),
                                  buildOTPField(_otpController2,
                                      _otpControllerFocusNode2),
                                  buildOTPField(_otpController3,
                                      _otpControllerFocusNode3),
                                  buildOTPField(_otpController4,
                                      _otpControllerFocusNode4),
                                  buildOTPField(_otpController5,
                                      _otpControllerFocusNode5),
                                  buildOTPField(_otpController6,
                                      _otpControllerFocusNode6),
                                ],
                              ),
                              if (_isVerifyPressed &&
                                  (_otpController1.text.isEmpty ||
                                      _otpController2.text.isEmpty ||
                                      _otpController3.text.isEmpty ||
                                      _otpController4.text.isEmpty ||
                                      _otpController5.text.isEmpty ||
                                      _otpController5.text.isEmpty))
                                const Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    'Please enter a valid Otp Number',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: 'PoppinsRegular',
                                        fontSize: 12),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _otpController1.clear();
                                      _otpController2.clear();
                                      _otpController3.clear();
                                      _otpController4.clear();
                                      _otpController5.clear();
                                      _otpController6.clear();
                                    });
                                    forgotPasswordVerificationViewModel
                                        .callReSendForgotPasswordVerificationApi(
                                      widget.localPhoneNumber,
                                      widget.localRegion,
                                      context,
                                    );
                                  },
                                  child: const Text(
                                    AppStrings.reSendOtp,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.blue,
                                        fontFamily: 'PoppinsSemiBold',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _isVerifyPressed = true;
                                  });
                                  if (_otpController1.text.isNotEmpty &&
                                      _otpController2.text.isNotEmpty &&
                                      _otpController3.text.isNotEmpty &&
                                      _otpController4.text.isNotEmpty &&
                                      _otpController5.text.isNotEmpty &&
                                      _otpController6.text.isNotEmpty) {
                                    FocusScope.of(context)
                                        .requestFocus(FocusNode());
                                    String enteredOtp = _otpController1.text +
                                        _otpController2.text +
                                        _otpController3.text +
                                        _otpController4.text +
                                        _otpController5.text +
                                        _otpController6.text;
                                    String correctOtp = viewModel.localOtp;
                                    if (enteredOtp == correctOtp) {
                                      CommonUtilities.showToast(context,
                                          message: "Success..!");
                                      Navigator.pushReplacement(
                                        context,
                                        PageRouteBuilder(
                                          pageBuilder: (context, animation,
                                              secondaryAnimation) {
                                            return ChangePasswordScreen(
                                                localPhoneNumber:
                                                    widget.localPhoneNumber);
                                          },
                                          transitionsBuilder: (context,
                                              animation,
                                              secondaryAnimation,
                                              child) {
                                            const begin = Offset(1.0,
                                                0.0); // Start from right to left
                                            const end = Offset
                                                .zero; // End at current position
                                            const curve = Curves
                                                .easeInOut; // Smooth transition
                                            var tween = Tween(
                                                    begin: begin, end: end)
                                                .chain(
                                                    CurveTween(curve: curve));
                                            var offsetAnimation =
                                                animation.drive(tween);
                                            return SlideTransition(
                                                position: offsetAnimation,
                                                child: child);
                                          },
                                        ),
                                      );
                                    } else {
                                      CommonUtilities.showToast(context,
                                          message:
                                              "Invalid OTP. Please try again.");
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 24),
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: const Text(
                                  AppStrings.verifyProceed,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'PoppinsSemiBold',
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 10,
                left: 10,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white, // Change this to your desired color
                  ),
                ),
              ),
            ]);
          }),
        ),
      ),
    );
  }

  Widget buildOTPField(TextEditingController controller, FocusNode focusNode) {
    return SizedBox(
      width: 45, // Adjust width as needed
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          boxShadow: focusNode.hasFocus
              ? [
                  BoxShadow(
                    color: Colors.blue.withOpacity(1),
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: const Offset(0, 1),
                  ),
                ]
              : [],
        ),
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          style: const TextStyle(
              color: Colors.white, fontFamily: 'PoppinsRegular', fontSize: 16),
          cursorColor: const Color(0xFF4370FF),
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFF0E0E22),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(
                color: Colors.white.withOpacity(1),
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: const BorderSide(
                color: Color(0xFF4370FF),
                width: 1,
              ),
            ),
          ),
          onTap: () {
            setState(() {});
          },
          onEditingComplete: () {
            setState(() {});
          },
          keyboardType: TextInputType.phone,
          maxLength: 1,
          buildCounter: (BuildContext context,
              {int? currentLength, int? maxLength, bool? isFocused}) {
            return null;
          },
          onChanged: (value) {
            if (value.isNotEmpty) {
              FocusScope.of(context).nextFocus();
            } else if (value.isEmpty) {
              FocusScope.of(context).previousFocus();
            }
          },
        ),
      ),
    );
  }
}
