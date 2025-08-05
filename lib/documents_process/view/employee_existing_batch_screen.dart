import 'package:cunning_document_scanner/cunning_document_scanner.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:salt_ware_tax/common/AppColors.dart';
import 'package:salt_ware_tax/common/AppStrings.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';
import 'package:salt_ware_tax/common/shared_pref.dart';
import 'package:salt_ware_tax/documents_process/model/existing_document_model.dart';
import 'package:salt_ware_tax/documents_process/view/existing_batch_folder_images.dart';
import 'package:salt_ware_tax/documents_process/view/scanned_documents.dart';
import 'package:salt_ware_tax/documents_process/viewModel/existing_document_based_on_employee_view_model.dart';

class EmployeeExistingBatchScreen extends StatefulWidget {
  final String projectId;
  final String projectName;

  const EmployeeExistingBatchScreen(
      {super.key, required this.projectId, required this.projectName});

  @override
  EmployeeExistingBatchScreenState createState() =>
      EmployeeExistingBatchScreenState();
}

class EmployeeExistingBatchScreenState
    extends State<EmployeeExistingBatchScreen> {
  final ExistingDocumentBasedOnEmployeeViewModel
      existingDocumentBasedOnEmployeeViewModel =
      ExistingDocumentBasedOnEmployeeViewModel();

  bool isGridView = true;

  bool isSorted = false;

  late String userId = '';

  final TextEditingController _searchController = TextEditingController();

  bool _isBatchCreatePressed = false;

  List<String> _scannedImagePaths = [];

  final _batchNameController = TextEditingController();
  final _batchNameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _getSharedPrefData();
  }

  Future<void> _getSharedPrefData() async {
    await SharedPrefsHelper.init();
    userId = SharedPrefsHelper.getString('user_id')!;

    if (userId.isNotEmpty) {
      existingDocumentBasedOnEmployeeViewModel.fetchFoldersList(
          userId, widget.projectId, context);
    }
  }

  void _toggleSortOrder() {
    setState(() {
      isSorted = !isSorted;
      if (isSorted) {
        existingDocumentBasedOnEmployeeViewModel.sortFoldersList();
      } else {
        existingDocumentBasedOnEmployeeViewModel.resetFoldersList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.customWhite,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showBottomPopup(context);
          },
          backgroundColor: AppColors.customGrey,
          shape: const CircleBorder(),
          tooltip: 'Add Folder',
          child: const Icon(
            Icons.add,
            color: AppColors.customBlack,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: ChangeNotifierProvider<ExistingDocumentBasedOnEmployeeViewModel>(
          create: (BuildContext context) =>
              existingDocumentBasedOnEmployeeViewModel,
          child: Consumer<ExistingDocumentBasedOnEmployeeViewModel>(
            builder: (context, viewModel, child) {
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Image.asset(
                                'assets/images/back_arrow.png',
                                color: AppColors.customBlack,
                                width: 30,
                                height: 30,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 1.0),
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
                                          viewModel.searchFolders(value);
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
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: AppColors.customBlue,
                                          ),
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 15.0),
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
                                    IconButton(
                                      icon: Image.asset(
                                        isGridView
                                            ? 'assets/icons/home_list.png'
                                            : 'assets/icons/home_grid.png',
                                        color: AppColors.customBlue,
                                        width: 25,
                                        height: 25,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isGridView = !isGridView;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Folders",
                              style: TextStyle(
                                  color: AppColors.customBlack,
                                  fontSize: 18.0,
                                  fontFamily: 'PoppinsSemiBold',
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        viewModel.noFolders
                            ? Expanded(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Lottie.asset('assets/loader/no_data.json',
                                          width: 150, height: 150),
                                      const SizedBox(height: 20),
                                      const Text(
                                        AppStrings.noFolders,
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
                                child: isGridView
                                    ? GridView.builder(
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 10.0,
                                          crossAxisCount: 3,
                                          childAspectRatio: 1,
                                          crossAxisSpacing: 10.0,
                                        ),
                                        itemCount: viewModel.foldersList.length,
                                        itemBuilder: (context, index) {
                                          return GridViewCard(
                                              index: index,
                                              documentViewModel:
                                                  existingDocumentBasedOnEmployeeViewModel,
                                              character:
                                                  viewModel.foldersList[index]);
                                        },
                                      )
                                    : ListView.builder(
                                        itemCount: viewModel.foldersList.length,
                                        itemBuilder: (context, index) {
                                          return ListViewCard(
                                              index: index,
                                              documentViewModel:
                                                  existingDocumentBasedOnEmployeeViewModel,
                                              character:
                                                  viewModel.foldersList[index]);
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
                                  const BoxShadow(
                                    color: Colors.blue,
                                    blurRadius: 5,
                                    spreadRadius: 1,
                                    offset: Offset(0, 1),
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
                              borderSide: const BorderSide(
                                color: Colors.white,
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
      required this.documentViewModel,
      required this.character});

  final ExistingDocumentResponse character;

  final int index;

  final ExistingDocumentBasedOnEmployeeViewModel documentViewModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return ExistingBatchFolderImagesScreen(
                  batchName: character.batchName,
                  images: character.images,
                  pdfUrl: character.pdfUrl);
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
            color: AppColors.customLightBlue.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            leading: Image.asset(
              'assets/icons/folder.png',
              width: 70,
              height: 70,
            ),
            title: Text(character.batchName,
                maxLines: 1,
                style: const TextStyle(
                  color: AppColors.customBlack,
                  fontSize: 14,
                  fontFamily: 'PoppinsRegular',
                )),
          ),
        ),
      ),
    );
  }
}

class GridViewCard extends StatelessWidget {
  const GridViewCard(
      {super.key,
      required this.index,
      required this.documentViewModel,
      required this.character});

  final ExistingDocumentResponse character;

  final int index;

  final ExistingDocumentBasedOnEmployeeViewModel documentViewModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return ExistingBatchFolderImagesScreen(
                  batchName: character.batchName,
                  images: character.images,
                  pdfUrl: character.pdfUrl);
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
      child: SizedBox(
        height: 100,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.customLightBlue.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Prevents unnecessary expansion
            children: [
              Image.asset(
                'assets/icons/folder.png',
                width: 70,
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.all(1),
                child: Center(
                  child: Text(
                    character.batchName,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.customBlack,
                      fontSize: 14,
                      fontFamily: 'PoppinsSemiBold',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 2)
            ],
          ),
        ),
      ),
    );
  }
}
