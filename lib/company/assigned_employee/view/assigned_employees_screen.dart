import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:salt_ware_tax/authentication/model/login_model.dart';
import 'package:salt_ware_tax/common/AppColors.dart';
import 'package:salt_ware_tax/common/AppStrings.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';
import 'package:salt_ware_tax/common/shared_pref.dart';
import 'package:salt_ware_tax/company/assigned_employee/model/assigned_employees_model.dart';
import 'package:salt_ware_tax/company/assigned_employee/view_model/assigned_employee_view_model.dart';

class AssignedEmployeesScreen extends StatefulWidget {
  final String projectId;

  const AssignedEmployeesScreen({super.key, required this.projectId});

  @override
  AssignedEmployeesScreenState createState() => AssignedEmployeesScreenState();
}

class AssignedEmployeesScreenState extends State<AssignedEmployeesScreen> {
  final AssignedEmployeeViewModel _assignedEmployeeViewModel =
      AssignedEmployeeViewModel();

  bool isSorted = false;

  late String companyName = '';

  final TextEditingController _searchController = TextEditingController();

  Set<String> selectedUserIds = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSharedPrefData();
    });
  }

  Future<void> getSharedPrefData() async {
    await SharedPrefsHelper.init();
    companyName = SharedPrefsHelper.getString('company_name')!;
    if (widget.projectId.isNotEmpty || companyName.isNotEmpty) {
      _assignedEmployeeViewModel.fetchCompanyBasedUsersList(
          widget.projectId, context);
    }
    selectedUserIds = _assignedEmployeeViewModel.assignedUserIds.toSet();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.customWhite,
        body: ChangeNotifierProvider<AssignedEmployeeViewModel>.value(
          value: _assignedEmployeeViewModel,
          child: Consumer<AssignedEmployeeViewModel>(
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
                                    width: 25, // Adjust size as needed
                                    height: 25,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    maxWidth: 180,
                                  ),
                                  child: const Text(
                                    'Assigned Users',
                                    style: const TextStyle(
                                      color: AppColors.customBlack,
                                      fontSize: 22,
                                      fontFamily: 'PoppinsSemiBold',
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    // Call API and get users list
                                    final List<LoginResponse> users =
                                        await viewModel.fetchAllUsersList(
                                            companyName, context);
                                    final assignedIds =
                                        _assignedEmployeeViewModel
                                            .assignedUserIds;
                                    List<String> selectedUserIds =
                                        List<String>.from(assignedIds);
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
                                                          final user =
                                                              users[index];
                                                          final isChecked =
                                                              selectedUserIds
                                                                  .contains(
                                                                      user.id);
                                                          return CheckboxListTile(
                                                            value: isChecked,
                                                            onChanged:
                                                                (bool? value) {
                                                              setState(() {
                                                                if (value ==
                                                                    true) {
                                                                  if (!selectedUserIds
                                                                      .contains(
                                                                          user.id)) {
                                                                    selectedUserIds
                                                                        .add(user
                                                                            .id);
                                                                  }
                                                                } else {
                                                                  selectedUserIds
                                                                      .remove(user
                                                                          .id);
                                                                }
                                                              });
                                                            },
                                                            title: Text(
                                                              '${user.firstName} ${user.lastName}',
                                                              style:
                                                                  const TextStyle(
                                                                color: AppColors
                                                                    .customBlack,
                                                                fontSize: 16.0,
                                                                fontFamily:
                                                                    'PoppinsRegular',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
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
                                                              AppStrings
                                                                  .noUsers,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                color: AppColors
                                                                    .customBlack,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
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
                                                      _assignedEmployeeViewModel
                                                          .updateAssignedUserIds(
                                                              selectedUserIds);
                                                      bool success =
                                                          await viewModel
                                                              .updateUserList(
                                                                  widget
                                                                      .projectId,
                                                                  selectedUserIds
                                                                      .join(
                                                                          ','),
                                                                  context);
                                                      if (success) {
                                                        _assignedEmployeeViewModel
                                                            .fetchCompanyBasedUsersList(
                                                                widget
                                                                    .projectId,
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
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          AppColors.customBlue,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 16,
                                                        horizontal: 24,
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
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
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 1.0),
                          decoration: BoxDecoration(
                            color: AppColors.customGrey,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.7),
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
                                    viewModel.searchUsers(value);
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
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
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
                                        AppStrings.noUsersAssigned,
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
                                        assignedEmployeeViewModel:
                                            _assignedEmployeeViewModel,
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
      ),
    );
  }
}

class ListViewCard extends StatelessWidget {
  const ListViewCard(
      {super.key,
      required this.index,
      required this.assignedEmployeeViewModel,
      required this.character});

  final AssignedEmployeesResponse character;

  final int index;

  final AssignedEmployeeViewModel assignedEmployeeViewModel;

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
            color: AppColors.customLightBlue.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            leading: Image.asset(
              'assets/icons/folder.png',
              width: 70,
              height: 70,
            ),
            title: Text('${character.firstName} ${character.lastName}',
                maxLines: 1,
                style: const TextStyle(
                  color: AppColors.customBlack,
                  fontSize: 14,
                  fontFamily: 'PoppinsSemiBold',
                )),
            subtitle: Text(character.createdDate,
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
