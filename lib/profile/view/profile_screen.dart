import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:salt_ware_tax/authentication/view/login_screen.dart';
import 'package:salt_ware_tax/common/AppColors.dart';
import 'package:salt_ware_tax/common/AppStrings.dart';
import 'package:salt_ware_tax/common/shared_pref.dart';
import 'package:salt_ware_tax/profile/viewModel/profile_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final ProfileViewModel profileViewModel = ProfileViewModel();

  late String userId = '';
  String loginType = '';

  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _nameFocusNode = FocusNode();
  final _phoneNumberFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

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
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _getSharedPrefData();
  }

  Future<void> _getSharedPrefData() async {
    await SharedPrefsHelper.init();
    userId = SharedPrefsHelper.getString('user_id')!;
    loginType = SharedPrefsHelper.getString('loginType')!;

    if (userId.isNotEmpty) {
      profileViewModel.getProfileDetails(userId, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.customDarkBlueBottomNavigation,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          AppStrings.profile,
          style: TextStyle(
            fontFamily: 'PoppinsSemiBold',
            fontSize: 26,
            color: Colors.white,
          ),
        ),
        actions: [
          InkWell(
            onTap: () async {
              bool? logout = await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text(
                    "Are you sure you want to log out?",
                    style: TextStyle(
                        color: AppColors.customDarkBlue,
                        fontFamily: 'PoppinsRegular',
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text("No",
                          style: TextStyle(
                              color: AppColors.customDarkBlue,
                              fontFamily: 'PoppinsRegular',
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ),
                    TextButton(
                      onPressed: () async {
                        await SharedPrefsHelper.clear();
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        await prefs.clear();
                        Navigator.of(context).pop(true);
                      },
                      child: const Text("Yes",
                          style: TextStyle(
                              color: AppColors.customDarkBlue,
                              fontFamily: 'PoppinsRegular',
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ),
                  ],
                ),
              );
              if (logout == true) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                  (route) => false,
                );
              }
            },
            child: Image.asset(
              color: Colors.white,
              'assets/images/log_out.png', // Replace with your image path
              width: 30, // Adjust size as needed
              height: 25,
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: ChangeNotifierProvider<ProfileViewModel>(
        create: (BuildContext context) => profileViewModel,
        child: Consumer<ProfileViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.userProfileDetails != null &&
                viewModel.userNameDetails != null) {
              _nameController.text = viewModel.userNameDetails!.firstName;
              _phoneNumberController.text = viewModel.userProfileDetails!.phone;
              _emailController.text = viewModel.userProfileDetails!.email;
              _passwordController.text = viewModel.userProfileDetails!.password;
            }
            return Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/home_background_gradient.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      Center(
                        child: Container(
                          width: 140, // radius * 2 + border width * 2
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white, // Border color
                              width: 2, // Border width
                            ),
                          ),
                          child: Lottie.asset('assets/loader/profile.json'),
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
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: _nameFocusNode.hasFocus
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
                          controller: _nameController,
                          focusNode: _nameFocusNode,
                          readOnly: true,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'PoppinsRegular',
                              fontSize: 16),
                          cursorColor: const Color(0xFF4370FF),
                          decoration: InputDecoration(
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
                      const SizedBox(height: 20),
                      const Text(
                        AppStrings.phoneNumber,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'PoppinsSemiBold',
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 5),
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
                          readOnly: true,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'PoppinsRegular',
                              fontSize: 16),
                          cursorColor: const Color(0xFF4370FF),
                          decoration: InputDecoration(
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
                      const SizedBox(height: 20),
                      const Text(
                        AppStrings.email,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'PoppinsSemiBold',
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: _emailFocusNode.hasFocus
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
                          controller: _emailController,
                          focusNode: _emailFocusNode,
                          readOnly: true,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'PoppinsRegular',
                              fontSize: 16),
                          cursorColor: const Color(0xFF4370FF),
                          decoration: InputDecoration(
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
                          readOnly: true,
                          style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'PoppinsRegular',
                              fontSize: 16),
                          cursorColor: const Color(0xFF4370FF),
                          decoration: InputDecoration(
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
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
