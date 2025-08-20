import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:salt_ware_tax/common/app_colors.dart';
import 'package:salt_ware_tax/common/app_strings.dart';
import 'package:salt_ware_tax/common/shared_pref.dart';
import 'package:salt_ware_tax/company/users/model/company_users_model.dart';
import 'package:salt_ware_tax/company/users/view/company_add_users_screen.dart';
import 'package:salt_ware_tax/company/users/view_model/company_users_screen_view_model.dart';

class CompanyUsersScreen extends StatefulWidget {
  const CompanyUsersScreen({super.key});

  @override
  CompanyUsersScreenState createState() => CompanyUsersScreenState();
}

class CompanyUsersScreenState extends State<CompanyUsersScreen> {
  final CompanyUsersViewModel companyUsersViewModel = CompanyUsersViewModel();

  bool isSorted = false;

  late String userId = '';

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getSharedPrefData();
  }

  Future<void> getSharedPrefData() async {
    await SharedPrefsHelper.init();
    userId = SharedPrefsHelper.getString('user_id')!;
    if (userId.isNotEmpty) {
      companyUsersViewModel.fetchCompanyBasedUsersList(userId, context);
    }
  }

  void _toggleSortOrder() {
    setState(() {
      isSorted = !isSorted;
      if (isSorted) {
        companyUsersViewModel.sortProjectsList();
      } else {
        companyUsersViewModel.resetProjectsList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.customWhite,
      body: ChangeNotifierProvider<CompanyUsersViewModel>(
        create: (BuildContext context) => companyUsersViewModel,
        child: Consumer<CompanyUsersViewModel>(
          builder: (context, viewModel, child) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 1.0),
                        decoration: BoxDecoration(
                          color: AppColors.customGrey,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withValues(alpha: 0.7),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _searchController,
                                onChanged: (value) {
                                  viewModel.searchProjects(value);
                                },
                                style: const TextStyle(
                                  color: AppColors.customBlack,
                                  fontFamily: 'PoppinsRegular',
                                  fontSize: 16,
                                ),
                                textAlignVertical: TextAlignVertical.center,
                                decoration: const InputDecoration(
                                  hintText: "Search",
                                  hintStyle: TextStyle(
                                    color: AppColors.customBlack,
                                    fontFamily: 'PoppinsRegular',
                                    fontSize: 16,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: AppColors.customBlue,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.symmetric(vertical: 15.0),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Image.asset(
                                'assets/icons/home_alpha.png',
                                color: AppColors.customBlue,
                                width: 25,
                                height: 25,
                              ),
                              onPressed: _toggleSortOrder,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Users",
                            style: TextStyle(
                                color: AppColors.customBlack,
                                fontSize: 18.0,
                                fontFamily: 'PoppinsSemiBold',
                                fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return const CompanyAddUsersScreen();
                                  },
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    const begin = Offset(
                                        1.0, 0.0); // Start from right to left
                                    const end =
                                        Offset.zero; // End at current position
                                    const curve =
                                        Curves.easeInOut; // Smooth transition
                                    var tween = Tween(begin: begin, end: end)
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
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(
                                color: AppColors.customBlue,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      viewModel.noUsers
                          ? Expanded(
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Lottie.asset('assets/loader/no_data.json',
                                        width: 150, height: 150),
                                    const SizedBox(height: 20),
                                    const Text(
                                      AppStrings.noUsers,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.customBlack,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'PoppinsRegular',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: viewModel.usersList.length,
                                itemBuilder: (context, index) {
                                  return ListViewCard(
                                      index: index,
                                      companyUsersViewModel:
                                          companyUsersViewModel,
                                      character: viewModel.usersList[index]);
                                },
                              ),
                            ),
                      const SizedBox(height: 10),
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

class ListViewCard extends StatelessWidget {
  const ListViewCard(
      {super.key,
      required this.index,
      required this.companyUsersViewModel,
      required this.character});

  final CompanyUsersResponse character;

  final int index;

  final CompanyUsersViewModel companyUsersViewModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   PageRouteBuilder(
        //     pageBuilder: (context, animation, secondaryAnimation) {
        //       return ExistingBatchFolderImagesScreen(
        //           batchId: character.id, batchName: character.description);
        //     },
        //     transitionsBuilder:
        //         (context, animation, secondaryAnimation, child) {
        //       const begin = Offset(1.0, 0.0); // Start from right to left
        //       const end = Offset.zero; // End at current position
        //       const curve = Curves.easeInOut; // Smooth transition
        //       var tween =
        //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        //       var offsetAnimation = animation.drive(tween);
        //       return SlideTransition(position: offsetAnimation, child: child);
        //     },
        //   ),
        // );
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.customLightBlue.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            leading: Image.asset(
              'assets/icons/folder.png',
              width: 70,
              height: 70,
            ),
            title: Text(character.firstName,
                maxLines: 1,
                style: const TextStyle(
                  color: AppColors.customBlack,
                  fontSize: 14,
                  fontFamily: 'PoppinsRegular',
                )),
            subtitle: Text(character.email,
                style: const TextStyle(
                  color: AppColors.customBlack,
                  fontSize: 10,
                  fontFamily: 'PoppinsRegular',
                )),
          ),
        ),
      ),
    );
  }
}
