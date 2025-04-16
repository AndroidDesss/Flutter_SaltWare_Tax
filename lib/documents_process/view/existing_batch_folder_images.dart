import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:salt_ware_tax/common/AppColors.dart';
import 'package:salt_ware_tax/common/AppStrings.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';
import 'package:salt_ware_tax/documents_process/viewModel/existing_batch_folder_images_view_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ExistingBatchFolderImagesScreen extends StatefulWidget {
  final String batchId;
  final String batchName;

  const ExistingBatchFolderImagesScreen({
    super.key,
    required this.batchId,
    required this.batchName,
  });

  @override
  ExistingBatchFolderImagesScreenState createState() =>
      ExistingBatchFolderImagesScreenState();
}

class ExistingBatchFolderImagesScreenState
    extends State<ExistingBatchFolderImagesScreen> {
  final ExistingBatchFolderImagesViewModel existingBatchFolderImagesViewModel =
      ExistingBatchFolderImagesViewModel();

  @override
  void initState() {
    super.initState();
    if (widget.batchId.isNotEmpty) {
      existingBatchFolderImagesViewModel.fetchBatchImagesList(
          widget.batchId, widget.batchName, context);
    }
  }

  Future<void> _launchUrl(String urlToLaunch) async {
    final Uri url = Uri.parse(urlToLaunch);
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    CommonUtilities.showToast(context, message: 'Pdf Url Copied to Clipboard');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.customWhite,
        body: ChangeNotifierProvider<ExistingBatchFolderImagesViewModel>(
          create: (BuildContext context) => existingBatchFolderImagesViewModel,
          child: Consumer<ExistingBatchFolderImagesViewModel>(
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
                                    widget.batchName,
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
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    _copyToClipboard(
                                        viewModel.pdfList.first.pdfPath);
                                  },
                                  child: Image.asset(
                                    color: AppColors.customBlack,
                                    'assets/images/copy_link.png', // Replace with your image path
                                    width: 30, // Adjust size as needed
                                    height: 30,
                                  ),
                                ),
                                const SizedBox(width: 25),
                                InkWell(
                                  onTap: () {
                                    _launchUrl(viewModel.pdfList.first.pdfPath);
                                  },
                                  child: Image.asset(
                                    color: AppColors.customBlack,
                                    'assets/images/open_link.png', // Replace with your image path
                                    width: 30, // Adjust size as needed
                                    height: 30,
                                  ),
                                ),
                                const SizedBox(width: 10),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        viewModel.noImages
                            ? Expanded(
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Lottie.asset('assets/loader/no_data.json',
                                          width: 150, height: 150),
                                      const SizedBox(height: 20),
                                      const Text(
                                        AppStrings.noImages,
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
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    child: StaggeredGrid.count(
                                      crossAxisCount: 4,
                                      mainAxisSpacing: 18,
                                      crossAxisSpacing: 18,
                                      children:
                                          _buildTiles(viewModel.imagesList),
                                    ),
                                  ),
                                ),
                              ),
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
          child: CategoryCard(image: imagesList[i].filePath),
        ),
      );
    }
    return tiles;
  }
}

class CategoryCard extends StatelessWidget {
  final String image;
  const CategoryCard({super.key, required this.image});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(
          color: AppColors.customBlue, // Border color
          width: 2, // Border width
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          image,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
                child: CircularProgressIndicator(
              color: AppColors.customBlack,
            ));
          },
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Icon(Icons.broken_image, size: 50, color: Colors.grey),
            );
          },
        ),
      ),
    );
  }
}
