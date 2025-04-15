import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salt_ware_tax/authentication/viewModel/forgot_password_view_model.dart';
import 'package:salt_ware_tax/common/AppColors.dart';
import 'package:salt_ware_tax/common/AppStrings.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ForgotPasswordScreenState createState() => ForgotPasswordScreenState();
}

class ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final ForgotPasswordViewModel forgotPasswordViewModel =
      ForgotPasswordViewModel();

  final _formKey = GlobalKey<FormState>();

  bool _isGetOtpPressed = false;

  late TextEditingController _phoneNumberController = TextEditingController();

  final FocusNode _phoneNumberFocusNode = FocusNode();

  String _selectedCountryCode = '91';

  final List<Map<String, String>> countryCodes = [
    {'code': '91', 'name': 'India'},
    {'code': '1', 'name': 'USA'},
  ];

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _phoneNumberFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPasswordViewModel>(
      create: (BuildContext context) => forgotPasswordViewModel,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.customWhite,
          body: Consumer<ForgotPasswordViewModel>(
            builder: (context, viewModel, child) {
              return Stack(
                children: [
                  Center(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Image.asset(
                                'assets/icons/app_logo.png',
                                width: 90,
                                height: 90,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: 35),
                              const Text(
                                AppStrings.forgotPassword,
                                style: TextStyle(
                                  color: AppColors.customBlack,
                                  fontFamily: 'PoppinsSemiBold',
                                  fontSize: 28,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Text(
                                  AppStrings.forgotPasswordContentText,
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
                                AppStrings.phoneNumber,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'PoppinsSemiBold',
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  // Country Code Dropdown
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                          color: Colors.white, width: 1),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: DropdownButton<String>(
                                      value: _selectedCountryCode,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _selectedCountryCode = newValue!;
                                        });
                                      },
                                      items: countryCodes
                                          .map<DropdownMenuItem<String>>(
                                              (Map<String, String> country) {
                                        return DropdownMenuItem<String>(
                                          value: country['code']!,
                                          child: Text(
                                            country['code']!,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                        );
                                      }).toList(),
                                      dropdownColor: Colors.black,
                                      style:
                                          const TextStyle(color: Colors.white),
                                      iconEnabledColor: Colors.white,
                                      iconSize: 24,
                                      underline: Container(),
                                    ),
                                  ),
                                  const SizedBox(width: 10), // Spacing
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        boxShadow: _phoneNumberFocusNode
                                                .hasFocus
                                            ? [
                                                BoxShadow(
                                                  color: Colors.blue
                                                      .withOpacity(1),
                                                  blurRadius: 5,
                                                  spreadRadius: 1,
                                                  offset: const Offset(0, 1),
                                                ),
                                              ]
                                            : [],
                                      ),
                                      child: TextFormField(
                                        controller: _phoneNumberController,
                                        focusNode: _phoneNumberFocusNode,
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 16),
                                        cursorColor: const Color(0xFF4370FF),
                                        decoration: InputDecoration(
                                          hintText: AppStrings.enterPhoneNumber,
                                          hintStyle: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            fontSize: 14,
                                          ),
                                          filled: true,
                                          fillColor: const Color(0xFF0E0E22),
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            borderSide: BorderSide(
                                              color:
                                                  Colors.white.withOpacity(1),
                                              width: 1,
                                            ),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
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
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              if (_isGetOtpPressed &&
                                  (_phoneNumberController.text.isEmpty ||
                                      _phoneNumberController.text.length < 10))
                                const Padding(
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    'Please enter a valid number',
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: 'PoppinsRegular',
                                        fontSize: 12),
                                  ),
                                ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _isGetOtpPressed = true;
                                      });
                                      if (_phoneNumberController
                                              .text.isNotEmpty &&
                                          _phoneNumberController.text.length ==
                                              10) {
                                        FocusScope.of(context)
                                            .requestFocus(FocusNode());
                                        forgotPasswordViewModel
                                            .callForgotPasswordApi(
                                                _phoneNumberController.text,
                                                _selectedCountryCode,
                                                context);
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
                                      AppStrings.getOtp,
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
                        color: AppColors.customBlack,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
