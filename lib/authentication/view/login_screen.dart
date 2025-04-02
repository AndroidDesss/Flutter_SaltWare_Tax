import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:salt_ware_tax/authentication/view/forgot_password_screen.dart';
import 'package:salt_ware_tax/authentication/view/new_user_sign_up_screen.dart';
import 'package:salt_ware_tax/authentication/viewModel/login_view_model.dart';
import 'package:salt_ware_tax/common/AppColors.dart';
import 'package:salt_ware_tax/common/AppStrings.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final LoginViewModel loginViewModel = LoginViewModel();

  final _formKey = GlobalKey<FormState>();

  bool _isLoginPressed = false;

  late TextEditingController _phoneNumberController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();

  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _phoneNumberController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _phoneNumberFocusNode.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginViewModel>(
      create: (BuildContext context) => loginViewModel,
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          final backNavigationAllowed = await _showExitConfirmationDialog();
          if (backNavigationAllowed) {
            if (mounted) {
              SystemNavigator.pop();
            }
          }
        },
        child: SafeArea(
          child: Scaffold(
            body:
                Consumer<LoginViewModel>(builder: (context, viewModel, child) {
              return Stack(children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage('assets/images/background_gradient.jpg'),
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
                            const SizedBox(height: 10),
                            Image.asset(
                              'assets/icons/app_logo.png',
                              width: 90,
                              height: 90,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 35),
                            const Text(
                              AppStrings.login,
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
                                AppStrings.loginContentText,
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
                              AppStrings.phoneNumber,
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
                                    boxShadow: _phoneNumberFocusNode.hasFocus
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
                                    controller: _phoneNumberController,
                                    focusNode: _phoneNumberFocusNode,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'PoppinsRegular',
                                        fontSize: 16),
                                    cursorColor: const Color(0xFF4370FF),
                                    decoration: InputDecoration(
                                      hintText: AppStrings.enterPhoneNumber,
                                      hintStyle: TextStyle(
                                        color: Colors.white.withOpacity(0.5),
                                        fontFamily: 'PoppinsRegular',
                                        fontSize: 14,
                                      ),
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
                                    maxLength: 10,
                                    buildCounter: (BuildContext context,
                                        {int? currentLength,
                                        int? maxLength,
                                        bool? isFocused}) {
                                      return null;
                                    },
                                  ),
                                ),
                                if (_isLoginPressed &&
                                    (_phoneNumberController.text.isEmpty ||
                                        _phoneNumberController.text.length <
                                            10))
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
                              ],
                            ),
                            const SizedBox(height: 20),
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
                                              color: Colors.blue.withOpacity(1),
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
                                    buildCounter: (BuildContext context,
                                        {int? currentLength,
                                        int? maxLength,
                                        bool? isFocused}) {
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            // Align(
                            //   alignment: Alignment.centerRight,
                            //   child: GestureDetector(
                            //     onTap: () {
                            //       Navigator.push(
                            //         context,
                            //         PageRouteBuilder(
                            //           pageBuilder: (context, animation,
                            //               secondaryAnimation) {
                            //             return const ForgotPasswordScreen();
                            //           },
                            //           transitionsBuilder: (context, animation,
                            //               secondaryAnimation, child) {
                            //             const begin = Offset(1.0,
                            //                 0.0); // Start from right to left
                            //             const end = Offset
                            //                 .zero; // End at current position
                            //             const curve = Curves
                            //                 .easeInOut; // Smooth transition
                            //             var tween = Tween(
                            //                     begin: begin, end: end)
                            //                 .chain(CurveTween(curve: curve));
                            //             var offsetAnimation =
                            //                 animation.drive(tween);
                            //             return SlideTransition(
                            //                 position: offsetAnimation,
                            //                 child: child);
                            //           },
                            //         ),
                            //       );
                            //     },
                            //     child: const Text(
                            //       AppStrings.forgotPassword,
                            //       textAlign: TextAlign.end,
                            //       style: TextStyle(
                            //         fontSize: 16,
                            //         color: Colors.blue,
                            //         fontFamily: 'PoppinsSemiBold',
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: AppStrings.alreadyHaveAccount,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white70,
                                          fontFamily: 'PoppinsRegular',
                                        ),
                                      ),
                                      TextSpan(
                                        text: AppStrings.registerHere,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.blue,
                                          fontFamily: 'PoppinsSemiBold',
                                        ), // color for "Register here"
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (context,
                                                    animation,
                                                    secondaryAnimation) {
                                                  return const NewUserSignUpScreen();
                                                },
                                                transitionsBuilder: (context,
                                                    animation,
                                                    secondaryAnimation,
                                                    child) {
                                                  const begin =
                                                      Offset(1.0, 0.0);
                                                  const end = Offset.zero;
                                                  const curve =
                                                      Curves.easeInOut;
                                                  var tween = Tween(
                                                          begin: begin,
                                                          end: end)
                                                      .chain(CurveTween(
                                                          curve: curve));
                                                  var offsetAnimation =
                                                      animation.drive(tween);
                                                  return SlideTransition(
                                                      position: offsetAnimation,
                                                      child: child);
                                                },
                                              ),
                                            );
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _isLoginPressed = true;
                                    });
                                    if (_phoneNumberController
                                            .text.isNotEmpty &&
                                        _phoneNumberController.text.length ==
                                            10 &&
                                        _passwordController.text.isNotEmpty &&
                                        _passwordController.text.length >= 8) {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      loginViewModel.callLoginApi(
                                          _phoneNumberController.text,
                                          _passwordController.text,
                                          context);
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
                                    AppStrings.login,
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
              ]);
            }),
          ),
        ),
      ),
    );
  }

  Future<bool> _showExitConfirmationDialog() async {
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            AppStrings.exitMessage,
            style: TextStyle(
                color: AppColors.customDarkBlue,
                fontFamily: 'PoppinsRegular',
                fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No',
                  style: TextStyle(
                    color: AppColors.customDarkBlue,
                    fontFamily: 'PoppinsRegular',
                    fontSize: 16,
                  )),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes',
                  style: TextStyle(
                    color: AppColors.customDarkBlue,
                    fontFamily: 'PoppinsRegular',
                    fontSize: 16,
                  )),
            ),
          ],
        );
      },
    );
    return shouldExit ?? false;
  }
}
