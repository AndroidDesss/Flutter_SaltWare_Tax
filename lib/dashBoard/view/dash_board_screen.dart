import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/material.dart';
import 'package:salt_ware_tax/authentication/view/login_screen.dart';
import 'package:salt_ware_tax/common/AppColors.dart';
import 'package:salt_ware_tax/common/AppStrings.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';
import 'package:salt_ware_tax/common/shared_pref.dart';
import 'package:salt_ware_tax/documents_process/view/existing_batch_document.dart';
import 'package:salt_ware_tax/documents_process/view/scanned_documents.dart';
import 'package:salt_ware_tax/profile/view/profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  DashBoardScreenState createState() => DashBoardScreenState();
}

class DashBoardScreenState extends State<DashBoardScreen> {
  int _selectedIndex = 0;
  bool _isBatchCreatePressed = false;
  final List<int> visitedPages = [];
  List<String> _scannedImagePaths = [];

  final List<String> _iconList = [
    'assets/icons/bottom_nav_home.png',
    'assets/icons/bottom_nav_profile.png',
  ];

  final _batchNameController = TextEditingController();
  final _batchNameFocusNode = FocusNode();

  final pages = [const ExistingBatchDocumentScreen(), const ProfileScreen()];

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

  Future<void> _showBottomPopup(BuildContext context) async {
    _isBatchCreatePressed = false;
    showModalBottomSheet(
      backgroundColor: AppColors.customDarkBlueBottomNavigation,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    AppStrings.batchNameContent,
                    style: TextStyle(
                      fontFamily: 'PoppinsSemiBold',
                      fontSize: 18,
                      color: Colors.white,
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
                              fontSize: 16),
                          cursorColor: const Color(0xFF4370FF),
                          decoration: InputDecoration(
                            hintText: "Enter batch name",
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
                        ),
                      ),
                      if (_isBatchCreatePressed &&
                          _batchNameController.text.isEmpty)
                        const Padding(
                          padding: EdgeInsets.only(top: 8),
                          child: Text(
                            'Please enter a valid batch name',
                            style: TextStyle(
                                color: Colors.red,
                                fontFamily: 'PoppinsRegular',
                                fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setModalState(() {
                        _isBatchCreatePressed = true;
                      });
                      if (_batchNameController.text.isNotEmpty) {
                        FocusScope.of(context).unfocus();
                        Navigator.pop(context);
                        _scanCameraGalleryDocuments(_batchNameController.text);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 32),
                    ),
                    child: const Text(
                      "Create",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'PoppinsRegular',
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  //Document Scanner
  Future<void> _scanCameraGalleryDocuments(String batchName) async {
    try {
      final List<String>? scannedImages =
          await CunningDocumentScanner.getPictures(
              isGalleryImportAllowed: true);
      if (scannedImages != null && scannedImages.isNotEmpty) {
        setState(() {
          _scannedImagePaths = scannedImages;
        });
        Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return ScannedDocumentsScreen(
                  imagePaths: _scannedImagePaths,
                  batchName: batchName,
                );
              },
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(1.0, 0.0);
                const end = Offset.zero;
                const curve = Curves.easeInOut;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);
                return SlideTransition(position: offsetAnimation, child: child);
              },
            ));
        CommonUtilities.showToast(context,
            message: 'Documents scanned successfully!');
      } else {
        CommonUtilities.showToast(context,
            message: 'No documents were scanned.');
      }
    } catch (e) {
      CommonUtilities.showToast(context, message: 'An error occurred: $e');
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
                SharedPreferences prefs = await SharedPreferences.getInstance();
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
      return Future.value(false); // Prevent app exit
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onPopScope,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.customDarkBlueBottomNavigation,
          body: pages[_selectedIndex],
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _showBottomPopup(context);
            },
            backgroundColor: Colors.black,
            shape: const CircleBorder(),
            child: Image.asset('assets/icons/bottom_nav_scan.png',
                width: 25, height: 25),
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
                          ? Colors.white
                          : Colors.grey, // Optional tint
                    ),
                    if (isActive)
                      Container(
                        margin: const EdgeInsets.only(top: 5),
                        width: 3,
                        height: 3,
                        color: Colors.white,
                      ),
                  ],
                ),
              );
            },
            activeIndex: _selectedIndex,
            gapLocation: GapLocation.center,
            notchSmoothness: NotchSmoothness.smoothEdge,
            onTap: navigateToPage,
            backgroundColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
