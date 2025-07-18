import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:salt_ware_tax/common/AppColors.dart';
import 'package:salt_ware_tax/common/AppStrings.dart';
import 'package:salt_ware_tax/common/shared_pref.dart';
import 'package:salt_ware_tax/documents_process/model/existing_document_model.dart';
import 'package:salt_ware_tax/documents_process/view/existing_batch_folder_images.dart';
import 'package:salt_ware_tax/documents_process/viewModel/existing_document_view_model.dart';

class ExistingBatchDocumentScreen extends StatefulWidget {
  const ExistingBatchDocumentScreen({super.key});

  @override
  ExistingBatchDocumentState createState() => ExistingBatchDocumentState();
}

class ExistingBatchDocumentState extends State<ExistingBatchDocumentScreen> {
  final ExistingDocumentViewModel existingDocumentViewModel =
      ExistingDocumentViewModel();

  bool isGridView = true;

  bool isSorted = false;

  late String userId = '';

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getSharedPrefData();
  }

  Future<void> _getSharedPrefData() async {
    await SharedPrefsHelper.init();
    userId = SharedPrefsHelper.getString('user_id')!;

    if (userId.isNotEmpty) {
      existingDocumentViewModel.fetchFoldersList(userId, context);
    }
  }

  void _toggleSortOrder() {
    setState(() {
      isSorted = !isSorted;
      if (isSorted) {
        existingDocumentViewModel.sortFoldersList();
      } else {
        existingDocumentViewModel.resetFoldersList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.customWhite,
      body: ChangeNotifierProvider<ExistingDocumentViewModel>(
        create: (BuildContext context) => existingDocumentViewModel,
        child: Consumer<ExistingDocumentViewModel>(
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
                                                existingDocumentViewModel,
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
                                                existingDocumentViewModel,
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
    );
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

  final ExistingDocumentViewModel documentViewModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return ExistingBatchFolderImagesScreen(
                  batchId: character.id, batchName: character.description);
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
            color: AppColors.customLightBlue.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ListTile(
            leading: Image.asset(
              'assets/icons/folder.png',
              width: 70,
              height: 70,
            ),
            title: Text(character.description,
                maxLines: 1,
                style: const TextStyle(
                  color: AppColors.customBlack,
                  fontSize: 14,
                  fontFamily: 'PoppinsRegular',
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

class GridViewCard extends StatelessWidget {
  const GridViewCard(
      {super.key,
      required this.index,
      required this.documentViewModel,
      required this.character});

  final ExistingDocumentResponse character;

  final int index;

  final ExistingDocumentViewModel documentViewModel;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return ExistingBatchFolderImagesScreen(
                  batchId: character.id, batchName: character.description);
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
        height: 150,
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
                padding: const EdgeInsets.all(2),
                child: Center(
                  child: Text(
                    character.description,
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
              const SizedBox(height: 2),
              Text(
                character.createdDate,
                style: const TextStyle(
                  color: AppColors.customBlack,
                  fontSize: 10,
                  fontFamily: 'PoppinsRegular',
                ),
              ),
              const SizedBox(height: 2),
            ],
          ),
        ),
      ),
    );
  }
}
