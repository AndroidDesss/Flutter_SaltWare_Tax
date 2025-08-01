import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:salt_ware_tax/authentication/view/login_screen.dart';
import 'package:salt_ware_tax/common/AppColors.dart';
import 'package:salt_ware_tax/common/shared_pref.dart';
import 'package:salt_ware_tax/documents_process/view/existing_project_screen.dart';
import 'package:salt_ware_tax/profile/view/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeDashBoardScreen extends StatefulWidget {
  const EmployeeDashBoardScreen({super.key});

  @override
  EmployeeDashBoardScreenState createState() => EmployeeDashBoardScreenState();
}

class EmployeeDashBoardScreenState extends State<EmployeeDashBoardScreen> {
  int _selectedIndex = 0;
  final List<int> visitedPages = [];

  final List<String> _iconList = [
    'assets/icons/bottom_nav_home.png',
    'assets/icons/bottom_nav_profile.png',
  ];

  final pages = [const ExistingProjectScreen(), const ProfileScreen()];

  @override
  void initState() {
    super.initState();
    if (visitedPages.isEmpty) {
      visitedPages.add(_selectedIndex);
    }
  }

  void navigateToPage(int index) {
    if (index != _selectedIndex) {
      setState(() {
        _selectedIndex = index;
        if (visitedPages.isEmpty || visitedPages.last != index) {
          visitedPages.add(index);
        }
      });
    }
  }

  Future<bool> _onPopScope() async {
    if (visitedPages.length > 1) {
      setState(() {
        visitedPages.removeLast();
        _selectedIndex = visitedPages.isNotEmpty ? visitedPages.last : 0;
      });
      return Future.value(false); // Prevent app exit
    } else {
      bool? logout = await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            "Are you sure you want to log out?",
            style: TextStyle(
                color: AppColors.customBlue,
                fontFamily: 'PoppinsRegular',
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text("No",
                  style: TextStyle(
                      color: AppColors.customBlue,
                      fontFamily: 'PoppinsRegular',
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
            ),
            TextButton(
              onPressed: () async {
                await SharedPrefsHelper.clear();
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.of(context).pop(true);
              },
              child: const Text("Yes",
                  style: TextStyle(
                      color: AppColors.customBlue,
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
      return Future.value(false); // Prevent app exit
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onPopScope,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.customWhite,
          body: pages[_selectedIndex],
          bottomNavigationBar: AnimatedBottomNavigationBar.builder(
            height: 60,
            itemCount: _iconList.length,
            tabBuilder: (int index, bool isActive) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      _iconList[index],
                      width: 30,
                      height: 30,
                      color: isActive
                          ? AppColors.customBlue
                          : AppColors.customBlue, // Optional tint
                    ),
                    if (isActive)
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        width: 3,
                        height: 3,
                        color: AppColors.customBlack,
                      ),
                  ],
                ),
              );
            },
            activeIndex: _selectedIndex,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.smoothEdge,
            onTap: navigateToPage,
            backgroundColor: AppColors.customGrey,
          ),
        ),
      ),
    );
  }
}
