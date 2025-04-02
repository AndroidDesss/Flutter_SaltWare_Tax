import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salt_ware_tax/authentication/viewModel/new_user_sign_up_screen_view_model.dart';
import 'package:salt_ware_tax/common/AppStrings.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';

class NewUserSignUpScreen extends StatefulWidget {
  const NewUserSignUpScreen({super.key});

  @override
  NewUserSignUpScreenState createState() => NewUserSignUpScreenState();
}

class NewUserSignUpScreenState extends State<NewUserSignUpScreen> {
  final NewUserSignUpScreenViewModel newUserSignUpScreenViewModel =
      NewUserSignUpScreenViewModel();

  final _formKey = GlobalKey<FormState>();

  bool _isSignUpPressed = false;

  late var _nameController = TextEditingController();
  late var _phoneNumberController = TextEditingController();
  late var _emailController = TextEditingController();
  late var _passwordController = TextEditingController();
  late var _confirmPasswordController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  String _selectedCountryCode = '91';

  String emailPattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";

  final List<Map<String, String>> countryCodes = [
    {'code': '91', 'name': 'India'},
    {'code': '1', 'name': 'USA'},
  ];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();
    _phoneNumberController.dispose();
    _phoneNumberFocusNode.dispose();
    _emailController.dispose();
    _emailFocusNode.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordController.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  bool isEmailValid(String email) {
    return RegExp(emailPattern).hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NewUserSignUpScreenViewModel>(
      create: (BuildContext context) => newUserSignUpScreenViewModel,
      child: SafeArea(
        child: Scaffold(
          body: Consumer<NewUserSignUpScreenViewModel>(
            builder: (context, viewModel, child) {
              return Stack(
                children: [
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
                                AppStrings.signUp,
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
                                  AppStrings.signUpContentText,
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
                                AppStrings.name,
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
                                      boxShadow: _nameFocusNode.hasFocus
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
                                      controller: _nameController,
                                      focusNode: _nameFocusNode,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'PoppinsRegular',
                                          fontSize: 16),
                                      cursorColor: const Color(0xFF4370FF),
                                      decoration: InputDecoration(
                                        hintText: AppStrings.enterName,
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
                                      keyboardType: TextInputType.text,
                                      buildCounter: (BuildContext context,
                                          {int? currentLength,
                                          int? maxLength,
                                          bool? isFocused}) {
                                        return null;
                                      },
                                    ),
                                  ),
                                  if (_isSignUpPressed &&
                                      _nameController.text.isEmpty)
                                    const Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        'Please enter a valid name',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: 'PoppinsRegular',
                                            fontSize: 12),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 10),
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
                                        maxLength: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                AppStrings.email,
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
                                      boxShadow: _emailFocusNode.hasFocus
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
                                      controller: _emailController,
                                      focusNode: _emailFocusNode,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'PoppinsRegular',
                                          fontSize: 16),
                                      cursorColor: const Color(0xFF4370FF),
                                      decoration: InputDecoration(
                                        hintText: AppStrings.enterEmail,
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
                                      keyboardType: TextInputType.emailAddress,
                                      buildCounter: (BuildContext context,
                                          {int? currentLength,
                                          int? maxLength,
                                          bool? isFocused}) {
                                        return null;
                                      },
                                    ),
                                  ),
                                  if (_isSignUpPressed &&
                                      !isEmailValid(_emailController.text))
                                    const Padding(
                                      padding: EdgeInsets.only(top: 8),
                                      child: Text(
                                        'Please enter a valid e-mail',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: 'PoppinsRegular',
                                            fontSize: 12),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 10),
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
                                      keyboardType: TextInputType.text,
                                      buildCounter: (BuildContext context,
                                          {int? currentLength,
                                          int? maxLength,
                                          bool? isFocused}) {
                                        return null;
                                      },
                                    ),
                                  ),
                                  if (_isSignUpPressed &&
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
                              const SizedBox(height: 10),
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
                                      keyboardType: TextInputType.text,
                                      buildCounter: (BuildContext context,
                                          {int? currentLength,
                                          int? maxLength,
                                          bool? isFocused}) {
                                        return null;
                                      },
                                    ),
                                  ),
                                  if (_isSignUpPressed &&
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
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        _isSignUpPressed = true;
                                      });
                                      if (_nameController.text.isNotEmpty &&
                                          _phoneNumberController
                                              .text.isNotEmpty &&
                                          _phoneNumberController.text.length >=
                                              10 &&
                                          _emailController.text.isNotEmpty &&
                                          _passwordController.text.isNotEmpty &&
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
                                          newUserSignUpScreenViewModel
                                              .callCheckUserApi(
                                                  _nameController.text,
                                                  _phoneNumberController.text,
                                                  _selectedCountryCode,
                                                  _emailController.text,
                                                  _passwordController.text,
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
                                      AppStrings.signUp,
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
