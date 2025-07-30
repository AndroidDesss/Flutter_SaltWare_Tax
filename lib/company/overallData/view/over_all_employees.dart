import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:salt_ware_tax/common/AppColors.dart';
import 'package:salt_ware_tax/common/AppStrings.dart';
import 'package:salt_ware_tax/company/overallData/model/over_all_data_model.dart';
import 'package:salt_ware_tax/company/overallData/view/over_all_batches.dart';
import 'package:salt_ware_tax/company/overallData/viewModel/over_all_data_view_model.dart';

class OverAllEmployeesScreen extends StatefulWidget {
  final String projectName;
  final List<EmployeeData> employeeData;

  const OverAllEmployeesScreen(
      {super.key, required this.projectName, required this.employeeData});

  @override
  OverAllEmployeesScreenState createState() => OverAllEmployeesScreenState();
}

class OverAllEmployeesScreenState extends State<OverAllEmployeesScreen> {
  final OverAllDataViewModel overAllDataViewModel = OverAllDataViewModel();

  late String userId = '';

  List<EmployeeData> filteredEmployees = [];

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredEmployees = widget.employeeData;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.customWhite,
        body: Stack(
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
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 1.0),
                    decoration: BoxDecoration(
                      color: AppColors.customGrey,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(1),
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
                              setState(() {
                                if (value.isEmpty) {
                                  filteredEmployees = widget.employeeData;
                                } else {
                                  filteredEmployees = widget.employeeData
                                      .where((employee) => employee.employeeName
                                          .toLowerCase()
                                          .contains(value.toLowerCase()))
                                      .toList();
                                }
                              });
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
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  widget.employeeData.isEmpty
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
                            itemCount: filteredEmployees.length,
                            itemBuilder: (context, index) {
                              return ListViewCard(
                                employee: filteredEmployees[index],
                              );
                            },
                          ),
                        ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ListViewCard extends StatelessWidget {
  final EmployeeData employee;

  const ListViewCard({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return OverAllBatchesScreen(
                employeeName: employee.employeeName,
                batchData: employee.batches,
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
            color: Colors.lightBlue.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            leading: Image.asset(
              'assets/icons/folder.png',
              width: 70,
              height: 70,
            ),
            title: Text(
              employee.employeeName,
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
