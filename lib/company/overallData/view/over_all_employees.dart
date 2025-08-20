import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:salt_ware_tax/common/app_colors.dart';
import 'package:salt_ware_tax/common/app_strings.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';
import 'package:salt_ware_tax/common/shared_pref.dart';
import 'package:salt_ware_tax/company/overallData/model/over_all_employee_model.dart';
import 'package:salt_ware_tax/company/overallData/model/over_all_un_assigned_employee_data.dart';
import 'package:salt_ware_tax/company/overallData/view/over_all_batches.dart';
import 'package:salt_ware_tax/company/overallData/viewModel/over_all_employee_view_model.dart';

class OverAllEmployeesScreen extends StatefulWidget {
  final String projectId;
  final String projectName;

  const OverAllEmployeesScreen(
      {super.key, required this.projectId, required this.projectName});

  @override
  OverAllEmployeesScreenState createState() => OverAllEmployeesScreenState();
}

class OverAllEmployeesScreenState extends State<OverAllEmployeesScreen> {
  final OverAllEmployeeViewModel overAllEmployeeViewModel =
      OverAllEmployeeViewModel();

  late String userId = '';
  Set<String> selectedUserIds = {};

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
      overAllEmployeeViewModel.fetchOverAllEmployeeDataList(
          userId, widget.projectId, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.customWhite,
        body: ChangeNotifierProvider<OverAllEmployeeViewModel>(
          create: (BuildContext context) => overAllEmployeeViewModel,
          child: Consumer<OverAllEmployeeViewModel>(
            builder: (context, viewModel, child) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Image.asset(
                                    color: AppColors.customBlack,
                                    'assets/images/back_arrow.png', // Replace with your image path
                                    width: 30, // Adjust size as needed
                                    height: 30,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 180,
                                  ),
                                  child: Text(
                                    widget.projectName,
                                    style: const TextStyle(
                                      color: AppColors.customBlack,
                                      fontSize: 20,
                                      fontFamily: 'PoppinsSemiBold',
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 1.0, horizontal: 8),
                                decoration: BoxDecoration(
                                  color: AppColors.customGrey,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withValues(
                                          alpha: 0.3), // visible shadow
                                      blurRadius: 6,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.search,
                                      color: AppColors.customBlue,
                                    ),
                                    const SizedBox(width: 8),
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
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        decoration: const InputDecoration(
                                          hintText: "Search",
                                          hintStyle: TextStyle(
                                            color: AppColors.customBlack,
                                            fontFamily: 'PoppinsRegular',
                                            fontSize: 16,
                                          ),
                                          border: InputBorder.none,
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 12),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            GestureDetector(
                              onTap: () async {
                                // Call API and get users list
                                final List<OverAllUnAssignedEmployeeResponse>
                                    users = await viewModel
                                        .fetchOverAllUnAssignedEmployeeDataList(
                                            userId, widget.projectId, context);

                                setState(() {
                                  selectedUserIds.clear(); // reset selection
                                });

                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.white,
                                      title: const Text(
                                        AppStrings.addUsers,
                                        style: TextStyle(
                                          color: AppColors.customBlack,
                                          fontSize: 24.0,
                                          fontFamily: 'PoppinsSemiBold',
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      content: StatefulBuilder(
                                        builder: (context, setState) {
                                          return SizedBox(
                                            width: double.maxFinite,
                                            height: 300,
                                            child: users.isNotEmpty
                                                ? ListView.builder(
                                                    itemCount: users.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final user = users[index];
                                                      final isChecked =
                                                          selectedUserIds
                                                              .contains(user
                                                                  .employeeId
                                                                  .toString());
                                                      return CheckboxListTile(
                                                        value: isChecked,
                                                        onChanged:
                                                            (bool? value) {
                                                          setState(() {
                                                            final idStr = user
                                                                .employeeId
                                                                .toString();
                                                            if (value == true) {
                                                              selectedUserIds
                                                                  .add(idStr);
                                                            } else {
                                                              selectedUserIds
                                                                  .remove(
                                                                      idStr);
                                                            }
                                                          });
                                                        },
                                                        title: Text(
                                                          user.userName,
                                                          style:
                                                              const TextStyle(
                                                            color: AppColors
                                                                .customBlack,
                                                            fontSize: 16.0,
                                                            fontFamily:
                                                                'PoppinsRegular',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  )
                                                : Center(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Lottie.asset(
                                                          'assets/loader/no_data.json',
                                                          width: 150,
                                                          height: 150,
                                                        ),
                                                        const SizedBox(
                                                            height: 20),
                                                        const Text(
                                                          AppStrings.noUsers,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: AppColors
                                                                .customBlack,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontFamily:
                                                                'PoppinsRegular',
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                          );
                                        },
                                      ),
                                      actions: users.isNotEmpty
                                          ? [
                                              ElevatedButton(
                                                onPressed: () async {
                                                  if (selectedUserIds
                                                      .isNotEmpty) {
                                                    bool success =
                                                        await viewModel
                                                            .updateUserList(
                                                                widget
                                                                    .projectId,
                                                                selectedUserIds
                                                                    .join(','),
                                                                userId,
                                                                context);
                                                    if (success) {
                                                      setState(() {
                                                        selectedUserIds
                                                            .clear(); // reset selection
                                                      });
                                                      overAllEmployeeViewModel
                                                          .fetchOverAllEmployeeDataList(
                                                              userId,
                                                              widget.projectId,
                                                              context);
                                                      CommonUtilities.showToast(
                                                          context,
                                                          message:
                                                              "Update successful..!");
                                                      Navigator.of(context)
                                                          .pop();
                                                    } else {
                                                      CommonUtilities.showToast(
                                                          context,
                                                          message:
                                                              "Update failed. Please try again..!");
                                                    }
                                                  } else {
                                                    CommonUtilities.showToast(
                                                        context,
                                                        message:
                                                            "Please Select the Users!");
                                                  }
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      AppColors.customBlue,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 16,
                                                    horizontal: 24,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                ),
                                                child: const Text(
                                                  AppStrings.update,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily:
                                                        'PoppinsSemiBold',
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              )
                                            ]
                                          : null,
                                    );
                                  },
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
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
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        overAllEmployeeViewModel.noOverAllData
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
                                  itemCount: viewModel.overAllDataList.length,
                                  itemBuilder: (context, index) {
                                    return ListViewCard(
                                      index: index,
                                      overAllDataViewModel:
                                          overAllEmployeeViewModel,
                                      character:
                                          viewModel.overAllDataList[index],
                                      projectId: widget.projectId,
                                    );
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
      ),
    );
  }
}

class ListViewCard extends StatelessWidget {
  const ListViewCard(
      {super.key,
      required this.index,
      required this.overAllDataViewModel,
      required this.character,
      required this.projectId});

  final EmployeeData character;

  final int index;

  final String projectId;

  final OverAllEmployeeViewModel overAllDataViewModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return OverAllBatchesScreen(
                employeeName: character.employeeName,
                employeeId: character.employeeId.toString(),
                employeeType: character.type,
                projectId: projectId,
              );
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(position: offsetAnimation, child: child);
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.lightBlue.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            leading: Image.asset(
              'assets/icons/folder.png',
              width: 70,
              height: 70,
            ),
            title: Text(
              character.employeeName,
              maxLines: 1,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontFamily: 'PoppinsRegular',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
