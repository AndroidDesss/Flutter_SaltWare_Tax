import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salt_ware_tax/authentication/viewModel/new_user_sign_up_screen_view_model.dart';
import 'package:salt_ware_tax/common/AppColors.dart';
import 'package:salt_ware_tax/common/AppStrings.dart';

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

  late var _userNameController = TextEditingController();
  late var _firstNameController = TextEditingController();
  late var _lastNameController = TextEditingController();
  late var _phoneNumberController = TextEditingController();
  late var _emailController = TextEditingController();
  late var _passwordController = TextEditingController();
  late var _taxPayerIdController = TextEditingController();

  final _userNameFocusNode = FocusNode();
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _taxPayerIdFocusNode = FocusNode();

  String emailPattern = r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$";

  @override
  void initState() {
    super.initState();
    _userNameController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _taxPayerIdController = TextEditingController();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _taxPayerIdController.dispose();
    _userNameFocusNode.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _taxPayerIdFocusNode.dispose();
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
          backgroundColor: AppColors.customWhite,
          body: Consumer<NewUserSignUpScreenViewModel>(
            builder: (context, viewModel, child) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Center(
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
                                const SizedBox(height: 30),
                                const Text(
                                  AppStrings.signUp,
                                  style: TextStyle(
                                      color: AppColors.customBlack,
                                      fontFamily: 'PoppinsSemiBold',
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 10),
                                const Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: Text(
                                    AppStrings.signUpContentText,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: AppColors.customBlack,
                                      fontFamily: 'PoppinsRegular',
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 15),
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
                                                  color: AppColors.customBlack
                                                      .withOpacity(0.5),
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
                                            fontSize: 16),
                                        cursorColor: AppColors.customBlue,
                                        decoration: InputDecoration(
                                          hintText: AppStrings.enterUserName,
                                          hintStyle: TextStyle(
                                              color: AppColors.customBlack
                                                  .withOpacity(0.5),
                                              fontFamily: 'PoppinsRegular',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          filled: true,
                                          fillColor: AppColors.customGrey,
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
                                        _userNameController.text.isEmpty)
                                      const Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: Text(
                                          'Please enter a valid UserName',
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
                                                      .withOpacity(0.5),
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
                                            color: AppColors.customBlack,
                                            fontFamily: 'PoppinsRegular',
                                            fontSize: 16),
                                        cursorColor: AppColors.customBlue,
                                        decoration: InputDecoration(
                                          hintText: AppStrings.enterPassword,
                                          hintStyle: TextStyle(
                                              color: AppColors.customBlack
                                                  .withOpacity(0.5),
                                              fontFamily: 'PoppinsRegular',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          filled: true,
                                          fillColor: AppColors.customGrey,
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
                                            _passwordController.text.length <
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
                                const SizedBox(height: 10),
                                const Text(
                                  AppStrings.firstName,
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
                                        boxShadow: _firstNameFocusNode.hasFocus
                                            ? [
                                                BoxShadow(
                                                  color: AppColors.customBlack
                                                      .withOpacity(0.5),
                                                  blurRadius: 5,
                                                  spreadRadius: 1,
                                                  offset: const Offset(0, 1),
                                                ),
                                              ]
                                            : [],
                                      ),
                                      child: TextFormField(
                                        controller: _firstNameController,
                                        focusNode: _firstNameFocusNode,
                                        style: const TextStyle(
                                            color: AppColors.customBlack,
                                            fontFamily: 'PoppinsRegular',
                                            fontSize: 16),
                                        cursorColor: AppColors.customBlue,
                                        decoration: InputDecoration(
                                          hintText: AppStrings.enterFirstName,
                                          hintStyle: TextStyle(
                                              color: AppColors.customBlack
                                                  .withOpacity(0.5),
                                              fontFamily: 'PoppinsRegular',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          filled: true,
                                          fillColor: AppColors.customGrey,
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
                                        _firstNameController.text.isEmpty)
                                      const Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: Text(
                                          'Please enter a valid FirstName',
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
                                  AppStrings.lastName,
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
                                        boxShadow: _lastNameFocusNode.hasFocus
                                            ? [
                                                BoxShadow(
                                                  color: AppColors.customBlack
                                                      .withOpacity(0.5),
                                                  blurRadius: 5,
                                                  spreadRadius: 1,
                                                  offset: const Offset(0, 1),
                                                ),
                                              ]
                                            : [],
                                      ),
                                      child: TextFormField(
                                        controller: _lastNameController,
                                        focusNode: _lastNameFocusNode,
                                        style: const TextStyle(
                                            color: AppColors.customBlack,
                                            fontFamily: 'PoppinsRegular',
                                            fontSize: 16),
                                        cursorColor: AppColors.customBlue,
                                        decoration: InputDecoration(
                                          hintText: AppStrings.enterLastName,
                                          hintStyle: TextStyle(
                                              color: AppColors.customBlack
                                                  .withOpacity(0.5),
                                              fontFamily: 'PoppinsRegular',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          filled: true,
                                          fillColor: AppColors.customGrey,
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
                                        _lastNameController.text.isEmpty)
                                      const Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: Text(
                                          'Please enter a valid LastName',
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
                                  AppStrings.email,
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
                                        boxShadow: _emailFocusNode.hasFocus
                                            ? [
                                                BoxShadow(
                                                  color: AppColors.customBlue
                                                      .withOpacity(0.5),
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
                                            color: AppColors.customBlack,
                                            fontFamily: 'PoppinsRegular',
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                        cursorColor: AppColors.customBlue,
                                        decoration: InputDecoration(
                                          hintText: AppStrings.enterEmail,
                                          hintStyle: TextStyle(
                                            color: AppColors.customBlack
                                                .withOpacity(0.5),
                                            fontFamily: 'PoppinsRegular',
                                            fontSize: 14,
                                          ),
                                          filled: true,
                                          fillColor: AppColors.customGrey,
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
                                        keyboardType:
                                            TextInputType.emailAddress,
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
                                  AppStrings.phoneNumber,
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
                                        boxShadow: _phoneNumberFocusNode
                                                .hasFocus
                                            ? [
                                                BoxShadow(
                                                  color: AppColors.customBlue
                                                      .withOpacity(0.5),
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
                                            color: AppColors.customBlack,
                                            fontSize: 16),
                                        cursorColor: AppColors.customBlue,
                                        decoration: InputDecoration(
                                          hintText: AppStrings.enterPhoneNumber,
                                          hintStyle: TextStyle(
                                              fontFamily: 'PoppinsRegular',
                                              color: AppColors.customBlack
                                                  .withOpacity(0.5),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          filled: true,
                                          fillColor: AppColors.customGrey,
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
                                      ),
                                    ),
                                    if (_isSignUpPressed &&
                                        (_phoneNumberController.text.isEmpty ||
                                            _phoneNumberController.text.length <
                                                10 ||
                                            _phoneNumberController.text.length >
                                                10))
                                      const Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: Text(
                                          'Please enter a valid PhoneNumber',
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
                                  AppStrings.taxPayerId,
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
                                        boxShadow: _taxPayerIdFocusNode.hasFocus
                                            ? [
                                                BoxShadow(
                                                  color: AppColors.customBlack
                                                      .withOpacity(0.5),
                                                  blurRadius: 5,
                                                  spreadRadius: 1,
                                                  offset: const Offset(0, 1),
                                                ),
                                              ]
                                            : [],
                                      ),
                                      child: TextFormField(
                                        controller: _taxPayerIdController,
                                        focusNode: _taxPayerIdFocusNode,
                                        style: const TextStyle(
                                            color: AppColors.customBlack,
                                            fontFamily: 'PoppinsRegular',
                                            fontSize: 16),
                                        cursorColor: AppColors.customBlue,
                                        decoration: InputDecoration(
                                          hintText: AppStrings.enterTaxPayer,
                                          hintStyle: TextStyle(
                                              color: AppColors.customBlack
                                                  .withOpacity(0.5),
                                              fontFamily: 'PoppinsRegular',
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          filled: true,
                                          fillColor: AppColors.customGrey,
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
                                        buildCounter: (BuildContext context,
                                            {int? currentLength,
                                            int? maxLength,
                                            bool? isFocused}) {
                                          return null;
                                        },
                                      ),
                                    ),
                                    if (_isSignUpPressed &&
                                        _taxPayerIdController.text.isEmpty)
                                      const Padding(
                                        padding: EdgeInsets.only(top: 8),
                                        child: Text(
                                          'Please enter a valid TaxPayer Id',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: 'PoppinsRegular',
                                              fontSize: 12),
                                        ),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _isSignUpPressed = true;
                                        });
                                        if (_validateInputs()) {
                                          FocusScope.of(context)
                                              .requestFocus(FocusNode());
                                          newUserSignUpScreenViewModel
                                              .callCheckUserApi(
                                                  _userNameController.text,
                                                  _passwordController.text,
                                                  _firstNameController.text,
                                                  _lastNameController.text,
                                                  _emailController.text,
                                                  _phoneNumberController.text,
                                                  _taxPayerIdController.text,
                                                  context);
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 24),
                                        backgroundColor: AppColors.customBlue,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                  ),
                  Positioned(
                    top: 5,
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

  bool _validateInputs() {
    bool isValid = true;
    RegExp emailRegex = RegExp(emailPattern);

    if (_userNameController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _firstNameController.text.isEmpty ||
        _lastNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneNumberController.text.isEmpty ||
        _phoneNumberController.text.length < 10 ||
        _phoneNumberController.text.length > 10 ||
        _taxPayerIdController.text.isEmpty) {
      isValid = false;
    }

    if (!emailRegex.hasMatch(_emailController.text)) {
      isValid = false;
    }
    return isValid;
  }
}
