import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:salt_ware_tax/common/AppColors.dart';
import 'package:salt_ware_tax/common/AppStrings.dart';
import 'package:salt_ware_tax/company/overallData/model/over_all_data_model.dart';
import 'package:salt_ware_tax/company/overallData/view/over_all_images.dart';
import 'package:salt_ware_tax/company/overallData/viewModel/over_all_data_view_model.dart';

class OverAllBatchesScreen extends StatefulWidget {
  final String employeeName;
  final List<BatchData> batchData;

  const OverAllBatchesScreen(
      {super.key, required this.employeeName, required this.batchData});

  @override
  OverAllBatchesScreenState createState() => OverAllBatchesScreenState();
}

class OverAllBatchesScreenState extends State<OverAllBatchesScreen> {
  final OverAllDataViewModel overAllDataViewModel = OverAllDataViewModel();

  late String userId = '';

  final TextEditingController _searchController = TextEditingController();

  List<BatchData> filteredBatches = [];

  @override
  void initState() {
    super.initState();
    filteredBatches = widget.batchData;
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
                              setState(() {
                                if (value.isEmpty) {
                                  filteredBatches = widget.batchData;
                                } else {
                                  filteredBatches = widget.batchData
                                      .where((batch) => batch.batchName
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
                  const SizedBox(height: 10),
                  widget.batchData.isEmpty
                      ? Expanded(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset('assets/loader/no_data.json',
                                    width: 150, height: 150),
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
                          ),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: filteredBatches.length,
                            itemBuilder: (context, index) {
                              return ListViewCard(
                                batchData: filteredBatches[index],
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
  final BatchData batchData;

  const ListViewCard({super.key, required this.batchData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return OverAllImagesScreen(
                batchName: batchData.batchName,
                images: batchData.images,
                pdfUrl: batchData.pdfUrl,
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
              batchData.batchName,
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
