import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salt_ware_tax/authentication/viewModel/change_password_view_model.dart';
import 'package:salt_ware_tax/common/AppStrings.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';

class ChangePasswordScreen extends StatefulWidget {
  final String localPhoneNumber;

  const ChangePasswordScreen({super.key, required this.localPhoneNumber});

  @override
  ChangePasswordScreenState createState() => ChangePasswordScreenState();
}

class ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final ChangePasswordViewModel changePasswordViewModel =
      ChangePasswordViewModel();

  final _formKey = GlobalKey<FormState>();

  bool _isChangePasswordPressed = false;

  late TextEditingController _passwordController = TextEditingController();
  late TextEditingController _confirmPasswordController =
      TextEditingController();

  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordController.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChangePasswordViewModel>(
      create: (BuildContext context) => changePasswordViewModel,
      child: SafeArea(
        child: Scaffold(
          body: Consumer<ChangePasswordViewModel>(
            builder: (context, viewModel, child) {
              return Stack(
                children: [
                  // Background Image
                  Container(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage('assets/images/background_gradient.jpg'),
                        fit: BoxFit.cover,
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
                              const SizedBox(height: 10),
                              Image.asset(
                                'assets/icons/app_logo.png',
                                width: 90,
                                height: 90,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(height: 35),
                              const Text(
                                AppStrings.changePassword,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'PoppinsSemiBold',
                                  fontSize: 28,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Padding(
                                padding: EdgeInsets.only(right: 10),
                                child: Text(
                                  AppStrings.changePasswordContentText,
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
                                AppStrings.password,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'PoppinsSemiBold',
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      boxShadow: _passwordFocusNode.hasFocus
                                          ? [
                                              BoxShadow(
                                                color:
                                                    Colors.blue.withOpacity(1),
                                                blurRadius: 5,
                                                spreadRadius: 1,
                                                offset: const Offset(0, 1),
                                              ),
                                            ]
                                          : [],
                                    ),
                                    child: TextFormField(
                                      controller: _passwordController,
                                      focusNode: _passwordFocusNode,
                                      obscureText: true,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'PoppinsRegular',
                                          fontSize: 16),
                                      cursorColor: const Color(0xFF4370FF),
                                      decoration: InputDecoration(
                                        hintText: AppStrings.enterPassword,
                                        hintStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontFamily: 'PoppinsRegular',
                                          fontSize: 14,
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xFF0E0E22),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          borderSide: BorderSide(
                                            color: Colors.white.withOpacity(1),
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
                                      buildCounter: (BuildContext context,
                                          {int? currentLength,
                                          int? maxLength,
                                          bool? isFocused}) {
                                        return null;
                                      },
                                    ),
                                  ),
                                  if (_isChangePasswordPressed &&
                                      (_passwordController.text.isEmpty ||
                                          _passwordController.text.length < 8))
                                    const Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        'Please enter a valid password',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: 'PoppinsRegular',
                                            fontSize: 12),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              const Text(
                                AppStrings.confirmPassword,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'PoppinsSemiBold',
                                  fontSize: 15,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      boxShadow: _confirmPasswordFocusNode
                                              .hasFocus
                                          ? [
                                              BoxShadow(
                                                color:
                                                    Colors.blue.withOpacity(1),
                                                blurRadius: 5,
                                                spreadRadius: 1,
                                                offset: const Offset(0, 1),
                                              ),
                                            ]
                                          : [],
                                    ),
                                    child: TextFormField(
                                      controller: _confirmPasswordController,
                                      focusNode: _confirmPasswordFocusNode,
                                      obscureText: true,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'PoppinsRegular',
                                          fontSize: 16),
                                      cursorColor: const Color(0xFF4370FF),
                                      decoration: InputDecoration(
                                        hintText: AppStrings.reEnterPassword,
                                        hintStyle: TextStyle(
                                          color: Colors.white.withOpacity(0.5),
                                          fontFamily: 'PoppinsRegular',
                                          fontSize: 14,
                                        ),
                                        filled: true,
                                        fillColor: const Color(0xFF0E0E22),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          borderSide: BorderSide(
                                            color: Colors.white.withOpacity(1),
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
                                      buildCounter: (BuildContext context,
                                          {int? currentLength,
                                          int? maxLength,
                                          bool? isFocused}) {
                                        return null;
                                      },
                                    ),
                                  ),
                                  if (_isChangePasswordPressed &&
                                      (_confirmPasswordController
                                              .text.isEmpty ||
                                          _confirmPasswordController
                                                  .text.length <
                                              8))
                                    const Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        'Please enter a valid password',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: 'PoppinsRegular',
                                            fontSize: 12),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 25),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _isChangePasswordPressed = true;
                                      });
                                      if (_passwordController.text.isNotEmpty &&
                                          _passwordController.text.length >=
                                              8 &&
                                          _confirmPasswordController
                                              .text.isNotEmpty &&
                                          _confirmPasswordController
                                                  .text.length >=
                                              8) {
                                        if (_passwordController.text ==
                                            _confirmPasswordController.text) {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          changePasswordViewModel
                                              .callChangePasswordApi(
                                                  widget.localPhoneNumber,
                                                  _confirmPasswordController
                                                      .text,
                                                  context);
                                        } else {
                                          CommonUtilities.showToast(context,
                                              message:
                                                  AppStrings.passwordNotMatch);
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
                                      AppStrings.confirm,
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
                        color: Colors.white,
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
