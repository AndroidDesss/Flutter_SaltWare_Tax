import 'package:salt_ware_tax/company/project/model/create_project_model.dart';
import 'package:salt_ware_tax/network/api_response.dart';
import 'package:salt_ware_tax/network/network_api_service.dart';
import 'package:salt_ware_tax/company/project/model/project_model.dart';

class ProjectRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<CommonApiResponse<ProjectResponse>> getProjectDetails(
      String userId) async {
    Map<String, String> body = {
      'user_id': userId,
    };
    try {
      final response = await _apiService.postResponse('view-projects/', body);

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

  Future<CommonApiResponse<CreateProjectResponse>> createProject(
      String projectName, String userId) async {
    Map<String, String> body = {'name': projectName, 'user_id': userId};
    try {
      final response = await _apiService.postResponse('createproject/', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => CreateProjectResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }
}
