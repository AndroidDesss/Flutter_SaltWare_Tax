import 'package:flutter/material.dart';
import 'package:salt_ware_tax/common/custom_loader.dart';
import 'package:salt_ware_tax/company/overallData/model/over_all_employee_batch_model.dart';
import 'package:salt_ware_tax/company/overallData/repository/over_all_repository.dart';

class OverAllEmployeeBatchDataViewModel extends ChangeNotifier {
  final OverAllRepository _overAllRepository = OverAllRepository();

  bool _noOverAllData = false;
  bool get noOverAllData => _noOverAllData;

  List<OverAllEmployeeBatchResponse> _overAllDataList = [];
  List<OverAllEmployeeBatchResponse> get overAllDataList => _overAllDataList;

  List<OverAllEmployeeBatchResponse> _originalOverAllDataList = [];

  List<OverAllEmployeeBatchResponse> _originalOverAllData = [];

  // OverAllData API
  Future<void> fetchOverAllEmployeeBatchDataList(
      String employeeId, String userId, BuildContext context) async {
    CustomLoader.showLoader(context);
    _setNoProjects(false);

    try {
      final response = await _overAllRepository.getOverAllEmployeeBatchDetails(
          employeeId, userId);
      if (response.data.isNotEmpty && response.status == 200) {
        List<OverAllEmployeeBatchResponse> filteredOverAllDataList =
            response.data;
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
        return folders.batches.first.batchName
            .toLowerCase()
            .contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  void resetProjectsList() {
    _overAllDataList = List.from(_originalOverAllDataList);
    notifyListeners();
  }
}
