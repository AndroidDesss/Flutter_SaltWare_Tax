import 'package:salt_ware_tax/company/assigned_employee/model/assigned_employees_model.dart';
import 'package:salt_ware_tax/company/project/model/project_model.dart';
import 'package:salt_ware_tax/network/api_response.dart';
import 'package:salt_ware_tax/network/network_api_service.dart';

class AssignedEmployeesRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<CommonApiResponse<AssignedEmployeesResponse>>
      getAssignedEmployeeBasedProjects(String projectId) async {
    Map<String, String> body = {
      'project_id': projectId,
    };
    try {
      final response = await _apiService.postResponse(
          'get_company_project_user_details', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => AssignedEmployeesResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonApiResponse<ProjectResponse>> uploadEmployeeBasedOnProjects(
      String projectId, String userIds) async {
    Map<String, String> body = {
      'table': 'accounts_projects',
      'id': projectId,
      'assigned_user': userIds
    };
    try {
      final response = await _apiService.postResponse('update', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => ProjectResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }
}
