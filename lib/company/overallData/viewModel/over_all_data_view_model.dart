import 'package:flutter/material.dart';
import 'package:salt_ware_tax/common/custom_loader.dart';
import 'package:salt_ware_tax/company/overallData/model/over_all_data_model.dart';
import 'package:salt_ware_tax/company/overallData/repository/over_all_repository.dart';

class OverAllDataViewModel extends ChangeNotifier {
  final OverAllRepository _overAllRepository = OverAllRepository();

  bool _noOverAllData = false;
  bool get noOverAllData => _noOverAllData;

  List<OverAllResponse> _overAllDataList = [];
  List<OverAllResponse> get overAllDataList => _overAllDataList;

  List<OverAllResponse> _originalOverAllDataList = [];

  List<OverAllResponse> _originalOverAllData = [];

  // OverAllData API
  Future<void> fetchOverAllDataList(String userId, BuildContext context) async {
    CustomLoader.showLoader(context);
    _setNoProjects(false);

    try {
      final response =
          await _overAllRepository.getOverAllCompanyDetails(userId);
      if (response.data.isNotEmpty && response.status == 200) {
        List<OverAllResponse> filteredOverAllDataList = response.data;
        if (filteredOverAllDataList.isNotEmpty) {
          _overAllDataList = filteredOverAllDataList;
          _originalOverAllDataList = List.from(filteredOverAllDataList);
          _originalOverAllData = List.from(filteredOverAllDataList);
        } else {
          _overAllDataList = [];
          _originalOverAllDataList = [];
          _originalOverAllData = [];
          _setNoProjects(true);
        }
      } else {
        _overAllDataList = [];
        _originalOverAllDataList = [];
        _originalOverAllData = [];
        _setNoProjects(true);
      }
    } catch (e) {
      _overAllDataList = [];
      _originalOverAllDataList = [];
      _originalOverAllData = [];
      _setNoProjects(true);
    } finally {
      CustomLoader.hideLoader();
      notifyListeners();
    }
  }

  // Reset the folders list to the original order
  void resetProjectsList() {
    _overAllDataList = List.from(_originalOverAllDataList);
    notifyListeners();
  }

  // Sort the folders list alphabetically by description
  void sortProjectsList() {
    _overAllDataList.sort((a, b) =>
        a.projectName.toLowerCase().compareTo(b.projectName.toLowerCase()));
    notifyListeners();
  }

  // No folders
  void _setNoProjects(bool value) {
    _noOverAllData = value;
    notifyListeners();
  }

  //search Folders
  void searchProjects(String query) {
    if (query.isEmpty) {
      _overAllDataList = List.from(_originalOverAllData);
    } else {
      _overAllDataList = _originalOverAllData.where((folders) {
        return folders.projectName.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }
}
