import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salt_ware_tax/authentication/viewModel/new_user_verification_view_model.dart';
import 'package:salt_ware_tax/common/AppColors.dart';
import 'package:salt_ware_tax/common/AppStrings.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';

class NewUserVerificationScreen extends StatefulWidget {
  final String localUserName;
  final String localPassword;
  final String localFirstName;
  final String localLastName;
  final String localEmail;
  final String localPhoneNumber;
  final String localCompanyName;
  final String localLoginType;

  const NewUserVerificationScreen(
      {super.key,
      required this.localUserName,
      required this.localPassword,
      required this.localFirstName,
      required this.localLastName,
      required this.localEmail,
      required this.localPhoneNumber,
      required this.localCompanyName,
      required this.localLoginType});

  @override
  NewUserVerificationScreenState createState() =>
      NewUserVerificationScreenState();
}

class NewUserVerificationScreenState extends State<NewUserVerificationScreen> {
  final NewUserVerificationViewModel newUserVerificationViewModel =
      NewUserVerificationViewModel();

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      newUserVerificationViewModel.callVerificationOtpApi(
        widget.localPhoneNumber,
        context,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewUserVerificationViewModel>(
      create: (BuildContext context) => newUserVerificationViewModel,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.customWhite,
          body: Consumer<NewUserVerificationViewModel>(
              builder: (context, viewModel, child) {
            return Stack(children: [
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
                            width: 200,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(height: 35),
                          const Text(
                            AppStrings.verification,
                            style: TextStyle(
                              color: AppColors.customBlack,
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
                                color: AppColors.customBlack,
                                fontFamily: 'PoppinsRegular',
                                fontSize: 14,
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            AppStrings.otp,
                            style: TextStyle(
                              color: AppColors.customBlack,
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
                                    newUserVerificationViewModel
                                        .callVerificationOtpApi(
                                            widget.localPhoneNumber, context);
                                  },
                                  child: const Text(
                                    AppStrings.reSendOtp,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: AppColors.customBlue,
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
                                      newUserVerificationViewModel
                                          .callSignUpApi(
                                              widget.localUserName,
                                              widget.localPassword,
                                              widget.localFirstName,
                                              widget.localLastName,
                                              widget.localEmail,
                                              widget.localPhoneNumber,
                                              widget.localCompanyName,
                                              widget.localLoginType,
                                              context);
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
                                  backgroundColor: AppColors.customBlue,
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
                    color: AppColors
                        .customBlack, // Change this to your desired color
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
              color: AppColors.customBlack,
              fontFamily: 'PoppinsRegular',
              fontSize: 16),
          cursorColor: AppColors.customBlue,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.customGrey,
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
                color: AppColors.customBlue,
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
