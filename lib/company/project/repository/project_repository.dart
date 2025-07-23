import 'package:salt_ware_tax/network/api_response.dart';
import 'package:salt_ware_tax/network/network_api_service.dart';
import 'package:salt_ware_tax/company/project/model/project_model.dart';

class ProjectRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<CommonApiResponse<ProjectResponse>> getProjectDetails(
      String userId) async {
    Map<String, String> body = {
      'table': 'accounts_projects',
      'user_id': userId,
    };
    try {
      final response = await _apiService.postResponse('read', body);

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

  Future<CommonApiResponse<ProjectResponse>> checkProjectDuplicate(
      String userId, String projectName) async {
    Map<String, String> body = {
      'table': 'accounts_projects',
      'user_id': userId,
      'description': projectName
    };
    try {
      // print("ServerResponse: $userId");
      // print("ServerResponse: $projectName");
      final response = await _apiService.postResponse('read', body);

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

  Future<CommonApiResponse<ProjectResponse>> createProject(
      String createdDate, String projectName, String userId) async {
    Map<String, String> body = {
      'table': 'accounts_projects',
      'created_date': createdDate,
      'description': projectName,
      'user_id': userId,
    };
    try {
      final response = await _apiService.postResponse('create', body);

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
