import 'package:salt_ware_tax/company/overallData/model/over_all_data_model.dart';
import 'package:salt_ware_tax/company/overallData/model/over_all_employee_batch_model.dart';
import 'package:salt_ware_tax/company/overallData/model/over_all_employee_model.dart';
import 'package:salt_ware_tax/company/overallData/model/over_all_un_assigned_employee_data.dart';
import 'package:salt_ware_tax/company/overallData/model/upload_employee_response.dart';
import 'package:salt_ware_tax/network/api_response.dart';
import 'package:salt_ware_tax/network/network_api_service.dart';

class OverAllRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<CommonApiResponse<OverAllResponse>> getOverAllCompanyDetails(
      String userId) async {
    Map<String, String> body = {
      'user_id': userId,
    };
    try {
      final response =
          await _apiService.postResponse('companydashboard/', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => OverAllResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonApiResponse<OverAllEmployeeResponse>> getOverAllEmployeeDetails(
      String userId, String projectId) async {
    Map<String, String> body = {'user_id': userId, 'project_id': projectId};
    try {
      final response =
          await _apiService.postResponse('view-assigned-employees/', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => OverAllEmployeeResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonApiResponse<OverAllUnAssignedEmployeeResponse>>
      getOverAllUnAssignedEmployeeDetails(
          String userId, String projectId) async {
    Map<String, String> body = {'user_id': userId, 'project_id': projectId};
    try {
      final response =
          await _apiService.postResponse('view-unassigned-employees/', body);

      if (response != null) {
        return CommonApiResponse.fromJson(response,
            (item) => OverAllUnAssignedEmployeeResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonApiResponse<UploadEmployeeResponse>>
      uploadEmployeeBasedOnProjects(
          String projectId, String employeeIds, String userId) async {
    Map<String, String> body = {
      'project_id': projectId,
      'employee_ids': employeeIds,
      'user_id': userId
    };
    try {
      final response = await _apiService.postResponse('assignemployee/', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => UploadEmployeeResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonApiResponse<OverAllEmployeeBatchResponse>>
      getOverAllEmployeeBatchDetails(String employeeId, String userId, String projectId) async {
    Map<String, String> body = {'user_id': userId, 'employee_id': employeeId, 'project_id': projectId};
    try {
      final response =
          await _apiService.postResponse('company_view_employee_files/', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => OverAllEmployeeBatchResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }
}
