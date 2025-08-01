import 'package:flutter/material.dart';
import 'package:salt_ware_tax/common/common_utilities.dart';
import 'package:salt_ware_tax/common/custom_loader.dart';
import 'package:salt_ware_tax/company/overallData/model/over_all_employee_model.dart';
import 'package:salt_ware_tax/company/overallData/model/over_all_un_assigned_employee_data.dart';
import 'package:salt_ware_tax/company/overallData/repository/over_all_repository.dart';

class OverAllEmployeeViewModel extends ChangeNotifier {
  final OverAllRepository _overAllRepository = OverAllRepository();

  bool _noOverAllData = false;
  bool get noOverAllData => _noOverAllData;

  List<OverAllEmployeeResponse> _overAllDataList = [];
  List<OverAllEmployeeResponse> get overAllDataList => _overAllDataList;

  List<OverAllEmployeeResponse> _originalOverAllDataList = [];

  List<OverAllEmployeeResponse> _originalOverAllData = [];

  bool _noOverAllUnAssignedData = false;
  bool get noOverAllUnAssignedData => _noOverAllUnAssignedData;

  List<OverAllUnAssignedEmployeeResponse> _overAllUnAssignedDataList = [];
  List<OverAllUnAssignedEmployeeResponse> get overAllUnAssignedDataList =>
      _overAllUnAssignedDataList;

  // OverAllData API
  Future<void> fetchOverAllEmployeeDataList(
      String userId, String projectId, BuildContext context) async {
    CustomLoader.showLoader(context);
    _setNoProjects(false);

    try {
      final response =
          await _overAllRepository.getOverAllEmployeeDetails(userId, projectId);
      if (response.data.isNotEmpty && response.status == 200) {
        List<OverAllEmployeeResponse> filteredOverAllDataList = response.data;
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

  Future<List<OverAllUnAssignedEmployeeResponse>>
      fetchOverAllUnAssignedEmployeeDataList(
          String userId, String projectId, BuildContext context) async {
    CustomLoader.showLoader(context);
    _setNoUnAssignedEmployee(false);

    List<OverAllUnAssignedEmployeeResponse> result = [];

    try {
      final response = await _overAllRepository
          .getOverAllUnAssignedEmployeeDetails(userId, projectId);
      if (response.data.isNotEmpty && response.status == 200) {
        if (response.data.isNotEmpty) {
          _overAllUnAssignedDataList = response.data;
          result = response.data;
        } else {
          _overAllUnAssignedDataList = [];
          _setNoUnAssignedEmployee(true);
        }
      } else {
        _overAllUnAssignedDataList = [];
        _setNoUnAssignedEmployee(true);
      }
    } catch (e) {
      _overAllUnAssignedDataList = [];
      _setNoUnAssignedEmployee(true);
    } finally {
      CustomLoader.hideLoader();
      notifyListeners();
    }

    return result;
  }

  Future<bool> updateUserList(String projectId, String employeeIds,
      String userId, BuildContext context) async {
    CustomLoader.showLoader(context);
    try {
      final response = await _overAllRepository.uploadEmployeeBasedOnProjects(
          projectId, employeeIds, userId);
      if (response.status == 200 && response.data.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      _showErrorMessage("Something went wrong..!", context);
      return false;
    } finally {
      CustomLoader.hideLoader();
      notifyListeners();
    }
  }

  void _showErrorMessage(String message, BuildContext context) {
    CommonUtilities.showToast(context, message: message);
  }

// No folders
  void _setNoUnAssignedEmployee(bool value) {
    _noOverAllUnAssignedData = value;
    notifyListeners();
  }
}
