import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:salt_ware_tax/common/AppColors.dart';
import 'package:salt_ware_tax/common/AppStrings.dart';
import 'package:salt_ware_tax/common/shared_pref.dart';
import 'package:salt_ware_tax/company/overallData/model/over_all_employee_batch_model.dart';
import 'package:salt_ware_tax/company/overallData/view/over_all_images.dart';
import 'package:salt_ware_tax/company/overallData/viewModel/over_all_employee_batch_data_view_model.dart';

class OverAllBatchesScreen extends StatefulWidget {
  final String employeeId;
  final String employeeName;

  const OverAllBatchesScreen(
      {super.key, required this.employeeId, required this.employeeName});

  @override
  OverAllBatchesScreenState createState() => OverAllBatchesScreenState();
}

class OverAllBatchesScreenState extends State<OverAllBatchesScreen> {
  final OverAllEmployeeBatchDataViewModel overAllEmployeeBatchDataViewModel =
      OverAllEmployeeBatchDataViewModel();

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
    if (userId.isNotEmpty && widget.employeeId.isNotEmpty) {
      overAllEmployeeBatchDataViewModel.fetchOverAllEmployeeBatchDataList(
          widget.employeeId, userId, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.customWhite,
        body: ChangeNotifierProvider<OverAllEmployeeBatchDataViewModel>(
          create: (BuildContext context) => overAllEmployeeBatchDataViewModel,
          child: Consumer<OverAllEmployeeBatchDataViewModel>(
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
                                    widget.employeeName,
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
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Builder(builder: (context) {
                            // filter out responses that have no batches
                            final displayList = viewModel.overAllDataList
                                .where((e) => e.batches.isNotEmpty)
                                .toList();

                            final noDisplayData = displayList.isEmpty;

                            if (noDisplayData) {
                              return Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Lottie.asset(
                                      'assets/loader/no_data.json',
                                      width: 150,
                                      height: 150,
                                    ),
                                    const SizedBox(height: 20),
                                    const Text(
                                      AppStrings.noProjects,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: AppColors.customBlack,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'PoppinsRegular',
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }

                            return ListView.builder(
                              itemCount: displayList.length,
                              itemBuilder: (context, index) {
                                return ListViewCard(
                                  index: index,
                                  overAllDataViewModel:
                                      overAllEmployeeBatchDataViewModel,
                                  character: displayList[index],
                                );
                              },
                            );
                          }),
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
      required this.character});

  final OverAllEmployeeBatchResponse character;

  final int index;

  final OverAllEmployeeBatchDataViewModel overAllDataViewModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return OverAllImagesScreen(
                batchName: character.batches.first.batchName,
                images: character.batches.first.images,
                pdfUrl: character.batches.first.pdfUrl,
              );
            },
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0); // Start from right to left
              const end = Offset.zero; // End at current position
              const curve = Curves.easeInOut; // Smooth transition
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
              character.batches.first.batchName,
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
