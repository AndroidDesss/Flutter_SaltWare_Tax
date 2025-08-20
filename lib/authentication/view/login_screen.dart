import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:salt_ware_tax/authentication/view/forgot_password_screen.dart';
import 'package:salt_ware_tax/authentication/view/new_user_sign_up_screen.dart';
import 'package:salt_ware_tax/authentication/viewModel/login_view_model.dart';
import 'package:salt_ware_tax/common/app_colors.dart';
import 'package:salt_ware_tax/common/app_strings.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final LoginViewModel loginViewModel = LoginViewModel();

  final _formKey = GlobalKey<FormState>();

  bool _isLoginPressed = false;

  late TextEditingController _userNameController = TextEditingController();
  late TextEditingController _passwordController = TextEditingController();

  final FocusNode _userNameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _userNameFocusNode.dispose();
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
            backgroundColor: AppColors.customWhite,
            body:
                Consumer<LoginViewModel>(builder: (context, viewModel, child) {
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
                            const SizedBox(height: 10),
                            Image.asset(
                              'assets/icons/app_logo.png',
                              width: 200,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(height: 35),
                            const Text(
                              AppStrings.login,
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
                                AppStrings.loginContentText,
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
                              AppStrings.userName,
                              style: TextStyle(
                                color: AppColors.customBlack,
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
                                    boxShadow: _userNameFocusNode.hasFocus
                                        ? [
                                            BoxShadow(
                                              color: AppColors.customBlue
                                                  .withValues(alpha: 0.5),
                                              blurRadius: 5,
                                              spreadRadius: 1,
                                              offset: const Offset(0, 1),
                                            ),
                                          ]
                                        : [],
                                  ),
                                  child: TextFormField(
                                    controller: _userNameController,
                                    focusNode: _userNameFocusNode,
                                    style: const TextStyle(
                                      color: AppColors.customBlack,
                                      fontFamily: 'PoppinsRegular',
                                      fontSize: 16,
                                    ),
                                    cursorColor: AppColors.customBlue,
                                    decoration: InputDecoration(
                                      hintText: AppStrings.enterUserName,
                                      hintStyle: TextStyle(
                                        color: AppColors.customBlack
                                            .withValues(alpha: 0.5),
                                        fontFamily: 'PoppinsRegular',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      filled: true,
                                      fillColor: AppColors.customGrey,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide(
                                          color:
                                              Colors.white.withValues(alpha: 1),
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
                                    keyboardType: TextInputType.emailAddress,
                                    buildCounter: (BuildContext context,
                                        {int? currentLength,
                                        int? maxLength,
                                        bool? isFocused}) {
                                      return null;
                                    },
                                  ),
                                ),
                                if (_isLoginPressed &&
                                    (_userNameController.text.isEmpty))
                                  const Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                      'Please enter a valid Email-Id',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: 'PoppinsRegular',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              AppStrings.password,
                              style: TextStyle(
                                color: AppColors.customBlack,
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
                                              color: AppColors.customBlue
                                                  .withValues(alpha: 0.5),
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
                                        color: AppColors.customBlack,
                                        fontFamily: 'PoppinsRegular',
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                    cursorColor: AppColors.customBlue,
                                    decoration: InputDecoration(
                                      hintText: AppStrings.enterPassword,
                                      hintStyle: TextStyle(
                                        color: AppColors.customBlack
                                            .withValues(alpha: 0.5),
                                        fontFamily: 'PoppinsRegular',
                                        fontSize: 14,
                                      ),
                                      filled: true,
                                      fillColor: AppColors.customGrey,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(6),
                                        borderSide: BorderSide(
                                          color:
                                              Colors.white.withValues(alpha: 1),
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
                                    buildCounter: (BuildContext context,
                                        {int? currentLength,
                                        int? maxLength,
                                        bool? isFocused}) {
                                      return null;
                                    },
                                  ),
                                ),
                                if (_isLoginPressed &&
                                    (_passwordController.text.isEmpty ||
                                        _passwordController.text.length < 8))
                                  const Padding(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Text(
                                      'Please enter a valid Password',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontFamily: 'PoppinsRegular',
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) {
                                        return const ForgotPasswordScreen();
                                      },
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        const begin = Offset(1.0,
                                            0.0); // Start from right to left
                                        const end = Offset
                                            .zero; // End at current position
                                        const curve = Curves
                                            .easeInOut; // Smooth transition
                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));
                                        var offsetAnimation =
                                            animation.drive(tween);
                                        return SlideTransition(
                                            position: offsetAnimation,
                                            child: child);
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  AppStrings.forgotPassword,
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppColors.customBlue,
                                    fontFamily: 'PoppinsSemiBold',
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      _isLoginPressed = true;
                                    });
                                    if (_passwordController.text.length >= 8) {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      loginViewModel.callLoginApi(
                                          _userNameController.text,
                                          _passwordController.text,
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
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(
                                        text: AppStrings.alreadyHaveAccount,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: AppColors.customBlack,
                                          fontFamily: 'PoppinsRegular',
                                        ),
                                      ),
                                      TextSpan(
                                        text: AppStrings.registerHere,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          color: AppColors.customBlue,
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
                              ],
                            ),
                            const SizedBox(height: 60),
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
                color: AppColors.customBlue,
                fontFamily: 'PoppinsRegular',
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('No',
                  style: TextStyle(
                      color: AppColors.customBlue,
                      fontFamily: 'PoppinsRegular',
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Yes',
                  style: TextStyle(
                      color: AppColors.customBlue,
                      fontFamily: 'PoppinsRegular',
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
    return shouldExit ?? false;
  }
}
