import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:salt_ware_tax/company/overallData/view/over_all_data_screen.dart';
import 'package:salt_ware_tax/company/project/viewModel/project_view_model.dart';
import 'package:salt_ware_tax/company/users/view/company_users_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:salt_ware_tax/authentication/view/login_screen.dart';
import 'package:salt_ware_tax/common/AppColors.dart';
import 'package:salt_ware_tax/common/AppStrings.dart';
import 'package:salt_ware_tax/common/shared_pref.dart';

class CompanyDashBoardScreen extends StatefulWidget {
  const CompanyDashBoardScreen({super.key});

  @override
  CompanyDashBoardScreenState createState() => CompanyDashBoardScreenState();
}

class CompanyDashBoardScreenState extends State<CompanyDashBoardScreen> {
  int _selectedIndex = 0;
  bool _isBatchCreatePressed = false;
  final List<int> visitedPages = [];
  final TextEditingController _batchNameController = TextEditingController();
  final FocusNode _batchNameFocusNode = FocusNode();
  final ProjectViewModel projectViewModel = ProjectViewModel();
  final GlobalKey<OverAllDataScreenState> _overAllDataScreenKey =
      GlobalKey<OverAllDataScreenState>();
  late List<Widget> pages;

  late String userId = '';

  final List<String> _iconList = [
    'assets/icons/bottom_nav_home.png',
    'assets/icons/bottom_nav_profile.png',
  ];

  @override
  void initState() {
    super.initState();
    getSharedPrefData();
    visitedPages.add(_selectedIndex);
    pages = [
      // ProjectScreen(key: _projectScreenKey),
      OverAllDataScreen(key: _overAllDataScreenKey),
      const CompanyUsersScreen()
      // const CompanyUsersScreen(),
    ];
  }

  Future<void> getSharedPrefData() async {
    await SharedPrefsHelper.init();
    userId = SharedPrefsHelper.getString('user_id')!;
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

  Future<void> _showCenterPopup(BuildContext context) async {
    _isBatchCreatePressed = false;

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return Dialog(
              backgroundColor: AppColors.customGrey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        AppStrings.projectContent,
                        style: TextStyle(
                          fontFamily: 'PoppinsSemiBold',
                          fontSize: 18,
                          color: AppColors.customBlack,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: _batchNameFocusNode.hasFocus
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
                              controller: _batchNameController,
                              focusNode: _batchNameFocusNode,
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: 'PoppinsRegular',
                                fontSize: 16,
                              ),
                              cursorColor: const Color(0xFF4370FF),
                              decoration: InputDecoration(
                                hintText: "Enter Project Name",
                                hintStyle: const TextStyle(
                                  color: Colors.white,
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
                            ),
                          ),
                          if (_isBatchCreatePressed &&
                              _batchNameController.text.isEmpty)
                            const Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                'Please enter a valid project name',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: 'PoppinsRegular',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          setDialogState(() {
                            _isBatchCreatePressed = true;
                          });

                          if (_batchNameController.text.isNotEmpty) {
                            FocusScope.of(context).unfocus();
                            final shouldRefresh =
                                await projectViewModel.addProjects(
                              _batchNameController.text.trim(),
                              userId,
                              context,
                            );
                            Navigator.pop(dialogContext);
                            if (shouldRefresh) {
                              _overAllDataScreenKey.currentState
                                  ?.getSharedPrefData();
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.customBlue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 32),
                        ),
                        child: const Text(
                          "Create",
                          style: TextStyle(
                            color: AppColors.customWhite,
                            fontFamily: 'PoppinsRegular',
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    _batchNameController.clear();
  }

  Future<bool> _onPopScope() async {
    if (visitedPages.length > 1) {
      setState(() {
        visitedPages.removeLast();
        _selectedIndex = visitedPages.last;
      });
      return false;
    } else {
      final shouldLogout = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text(
            "Are you sure you want to log out?",
            style: TextStyle(
              color: AppColors.customBlue,
              fontFamily: 'PoppinsRegular',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
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
                final prefs = await SharedPreferences.getInstance();
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

      if (shouldLogout == true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
          (route) => false,
        );
      }
      return false;
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
          floatingActionButton: FloatingActionButton(
            onPressed: () => _showCenterPopup(context),
            backgroundColor: AppColors.customGrey,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.add,
              color: AppColors.customBlue,
              size: 30, // You can adjust the size as needed
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
                          : AppColors.customBlue,
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
