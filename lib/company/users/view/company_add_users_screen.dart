import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:salt_ware_tax/common/app_colors.dart';
import 'package:salt_ware_tax/common/app_strings.dart';
import 'package:salt_ware_tax/common/shared_pref.dart';
import 'package:salt_ware_tax/company/users/view_model/company_add_users_view_model.dart';

class CompanyAddUsersScreen extends StatefulWidget {
  const CompanyAddUsersScreen({super.key});

  @override
  CompanyAddUsersScreenState createState() => CompanyAddUsersScreenState();
}

class CompanyAddUsersScreenState extends State<CompanyAddUsersScreen> {
  final CompanyAddUsersViewModel companyAddUsersViewModel =
      CompanyAddUsersViewModel();

  final _formKey = GlobalKey<FormState>();

  bool _isSignUpPressed = false;

  late String userId = '';

  late var _userNameController = TextEditingController();
  late var _firstNameController = TextEditingController();
  late var _lastNameController = TextEditingController();
  late var _phoneNumberController = TextEditingController();
  late var _emailController = TextEditingController();
  late var _passwordController = TextEditingController();

  final _userNameFocusNode = FocusNode();
  final _firstNameFocusNode = FocusNode();
  final _lastNameFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

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
    _getSharedPrefData();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _userNameFocusNode.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  bool isEmailValid(String email) {
    return RegExp(emailPattern).hasMatch(email);
  }

  Future<void> _getSharedPrefData() async {
    await SharedPrefsHelper.init();
    userId = SharedPrefsHelper.getString('user_id')!;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CompanyAddUsersViewModel>(
      create: (BuildContext context) => companyAddUsersViewModel,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.customWhite,
          body: Consumer<CompanyAddUsersViewModel>(
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
                                const SizedBox(height: 10),
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
                                                      .withAlpha(255),
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
                                                  .withAlpha(255),
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
                                                  Colors.white.withAlpha(255),
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
                                const SizedBox(height: 5),
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
                                                      .withAlpha(255),
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
                                                  .withAlpha(255),
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
                                                  Colors.white.withAlpha(255),
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
                                const SizedBox(height: 5),
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
                                                      .withAlpha(128),
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
                                                  .withAlpha(128),
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
                                                  Colors.white.withAlpha(255),
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
                                const SizedBox(height: 5),
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
                                                      .withAlpha(128),
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
                                                  .withAlpha(128),
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
                                                  Colors.white.withAlpha(255),
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
                                const SizedBox(height: 5),
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
                                                      .withAlpha(128),
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
                                                .withAlpha(128),
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
                                                  Colors.white.withAlpha(255),
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
                                const SizedBox(height: 5),
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
                                                      .withAlpha(128),
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
                                                  .withAlpha(128),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          filled: true,
                                          fillColor: AppColors.customGrey,
                                          enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                            borderSide: BorderSide(
                                              color:
                                                  Colors.white.withAlpha(255),
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

                                          companyAddUsersViewModel
                                              .callSignUpApi(
                                                  _userNameController.text,
                                                  _passwordController.text,
                                                  _firstNameController.text,
                                                  _lastNameController.text,
                                                  _emailController.text,
                                                  _phoneNumberController.text,
                                                  userId,
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
    if (_userNameController.text.isEmpty) isValid = false;
    if (_passwordController.text.isEmpty ||
        _passwordController.text.length < 8) {
      isValid = false;
    }
    if (_emailController.text.isEmpty || !isEmailValid(_emailController.text)) {
      isValid = false;
    }
    if (_phoneNumberController.text.length != 10) isValid = false;
    if (_firstNameController.text.isEmpty) isValid = false;
    if (_lastNameController.text.isEmpty) isValid = false;
    return isValid;
  }
}
