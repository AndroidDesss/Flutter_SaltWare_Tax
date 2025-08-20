import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:salt_ware_tax/common/app_colors.dart';
import 'package:salt_ware_tax/common/app_strings.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';
import 'package:salt_ware_tax/common/shared_pref.dart';
import 'package:salt_ware_tax/documents_process/viewModel/scanned_documents_view_model.dart';

class ScannedDocumentsScreen extends StatefulWidget {
  final List<String> imagePaths;
  final String batchName;
  final String projectId;

  const ScannedDocumentsScreen(
      {super.key,
      required this.imagePaths,
      required this.batchName,
      required this.projectId});

  @override
  ScannedDocumentsScreenState createState() => ScannedDocumentsScreenState();
}

class ScannedDocumentsScreenState extends State<ScannedDocumentsScreen> {
  late List<String> _imagePaths;

  final ScannedDocumentsViewModel scannedDocumentsViewModel =
      ScannedDocumentsViewModel();

  late String userId = '';

  @override
  void initState() {
    super.initState();
    _imagePaths = List.from(widget.imagePaths);
    _getSharedPrefData();
  }

  Future<void> _getSharedPrefData() async {
    await SharedPrefsHelper.init();
    userId = SharedPrefsHelper.getString('user_id')!;
  }

  void _deleteImage(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            AppStrings.deleteImage,
            style: TextStyle(
                color: AppColors.customBlue,
                fontFamily: 'PoppinsRegular',
                fontSize: 18),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('No',
                  style: TextStyle(
                    color: AppColors.customBlue,
                    fontFamily: 'PoppinsRegular',
                    fontSize: 16,
                  )),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _imagePaths.removeAt(index); // Remove image at index
                });
                Navigator.pop(context);
              },
              child: const Text('Yes',
                  style: TextStyle(
                    color: AppColors.customBlue,
                    fontFamily: 'PoppinsRegular',
                    fontSize: 16,
                  )),
            ),
          ],
        );
      },
    );
  }

  void _uploadImages() {
    if (_imagePaths.isEmpty) {
      CommonUtilities.showToast(context, message: 'No images to upload.');
    } else {
      List<File> files = _imagePaths.map((path) => File(path)).toList();
      scannedDocumentsViewModel.postDocuments(
        widget.batchName,
        userId,
        files,
        widget.projectId,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.customWhite,
      body: ChangeNotifierProvider<ScannedDocumentsViewModel>(
          create: (BuildContext context) => scannedDocumentsViewModel,
          child: Consumer<ScannedDocumentsViewModel>(
              builder: (context, viewModel, child) {
            return Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/home_background_gradient.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.arrow_back,
                                  color: AppColors.customBlack,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Center(
                                child: Text(
                                  AppStrings.scannedDocuments,
                                  style: TextStyle(
                                    color: AppColors.customBlack,
                                    fontSize: 20.0,
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
                      const SizedBox(height: 10),
                      _imagePaths.isNotEmpty
                          ? Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: StaggeredGrid.count(
                                    crossAxisCount: 4,
                                    mainAxisSpacing: 18,
                                    crossAxisSpacing: 18,
                                    children: _buildTiles(_imagePaths),
                                  ),
                                ),
                              ),
                            )
                          : const Center(
                              child: Text(
                                'No scanned documents yet..!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: AppColors.customBlack,
                                  fontFamily: 'PoppinsSemiBold',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            );
          })),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _uploadImages,
        icon: const Icon(
          Icons.cloud_upload,
          color: AppColors.customWhite,
        ),
        label: const Text('Upload',
            style: TextStyle(
              color: AppColors.customWhite,
              fontFamily: 'PoppinsSemiBold',
              fontWeight: FontWeight.bold,
              fontSize: 16,
            )),
        backgroundColor: AppColors.customBlue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  List<Widget> _buildTiles(List<dynamic> imagesList) {
    List<StaggeredGridTile> tiles = [];
    for (int i = 0; i < imagesList.length; i++) {
      int crossAxisCount;
      int mainAxisCount;
      if (i % 5 == 0) {
        crossAxisCount = 2;
        mainAxisCount = 2;
      } else if (i % 5 == 1) {
        crossAxisCount = 2;
        mainAxisCount = 1;
      } else if (i % 5 == 4) {
        crossAxisCount = 4;
        mainAxisCount = 2;
      } else {
        crossAxisCount = 1;
        mainAxisCount = 1;
      }
      tiles.add(
        StaggeredGridTile.count(
          crossAxisCellCount: crossAxisCount,
          mainAxisCellCount: mainAxisCount,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 4,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(19),
                    border: Border.all(
                      color: AppColors.customBlue, // Border color
                      width: 2, // Border width
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      File(imagesList[i]),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.black54,
                    child: IconButton(
                      onPressed: () => _deleteImage(i),
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return tiles;
  }
}
