import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:salt_ware_tax/common/AppColors.dart';
import 'package:salt_ware_tax/common/AppStrings.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';
import 'package:salt_ware_tax/common/shared_pref.dart';
import 'package:salt_ware_tax/company/overallData/model/over_all_employee_batch_model.dart';
import 'package:salt_ware_tax/company/overallData/view/over_all_images.dart';
import 'package:salt_ware_tax/company/overallData/viewModel/over_all_employee_batch_data_view_model.dart';
import 'package:salt_ware_tax/documents_process/view/scanned_documents.dart';

class OverAllBatchesScreen extends StatefulWidget {
  final String employeeId;
  final String employeeName;
  final String employeeType;
  final String projectId;

  const OverAllBatchesScreen(
      {super.key,
      required this.employeeId,
      required this.employeeName,
      required this.employeeType,
      required this.projectId});

  @override
  OverAllBatchesScreenState createState() => OverAllBatchesScreenState();
}

class OverAllBatchesScreenState extends State<OverAllBatchesScreen> {
  final OverAllEmployeeBatchDataViewModel overAllEmployeeBatchDataViewModel =
      OverAllEmployeeBatchDataViewModel();

  late String userId = '';

  bool _isBatchCreatePressed = false;

  List<String> _scannedImagePaths = [];

  final TextEditingController _searchController = TextEditingController();

  final _batchNameController = TextEditingController();
  final _batchNameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    getSharedPrefData();
  }

  Future<void> getSharedPrefData() async {
    await SharedPrefsHelper.init();
    userId = SharedPrefsHelper.getString('user_id')!;
    if (widget.employeeType == 'employee') {
      if (userId.isNotEmpty && widget.employeeId.isNotEmpty) {
        overAllEmployeeBatchDataViewModel.fetchOverAllEmployeeBatchDataList(
            widget.employeeId, userId, widget.projectId, context);
      }
    } else if (widget.employeeType == 'company') {
      if (userId.isNotEmpty && widget.employeeId.isNotEmpty) {
        overAllEmployeeBatchDataViewModel.fetchOverAllEmployeeBatchDataList(
            '', userId, widget.projectId, context);
      }
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
                                      color: Colors.grey
                                          .withOpacity(0.3), // visible shadow
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
                            if (widget.employeeType.toLowerCase() == "company")
                              GestureDetector(
                                onTap: () async {
                                  _showBottomPopup(context);
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
                        const SizedBox(height: 10),
                        Expanded(
                          child: Builder(builder: (context) {
                            final List<BatchData> batchEntries = viewModel
                                .overAllDataList
                                .where((e) => e.batches.isNotEmpty)
                                .expand((e) => e.batches.map((b) => BatchData(
                                    batchId: b.batchId,
                                    batchName: b.batchName,
                                    images: b.images,
                                    pdfUrl: b.pdfUrl)))
                                .toList();
                            final noDisplayData = batchEntries.isEmpty;
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
                                      AppStrings.noBatches,
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
                              itemCount: batchEntries.length,
                              itemBuilder: (context, index) {
                                return ListViewCard(
                                  index: index,
                                  overAllDataViewModel:
                                      overAllEmployeeBatchDataViewModel,
                                  character: batchEntries[index],
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

  Future<void> _showBottomPopup(BuildContext context) async {
    _isBatchCreatePressed = false;
    showModalBottomSheet(
      backgroundColor: AppColors.customGrey,
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
                              fontSize: 16),
                          cursorColor: const Color(0xFF4370FF),
                          decoration: InputDecoration(
                            hintText: "Enter batch name",
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
                  projectId: widget.projectId,
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
}

class ListViewCard extends StatelessWidget {
  const ListViewCard(
      {super.key,
      required this.index,
      required this.overAllDataViewModel,
      required this.character});

  final BatchData character;

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
                batchName: character.batchName,
                images: character.images,
                pdfUrl: character.pdfUrl,
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
              character.batchName,
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
