import 'package:salt_ware_tax/documents_process/model/existing_project_model.dart';
import 'package:salt_ware_tax/network/api_response.dart';
import 'package:salt_ware_tax/network/network_api_service.dart';

class ExistingProjectRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<CommonApiResponse<ExistingProjectResponse>> getProjectList(
      String userId) async {
    Map<String, String> body = {
      'user_id': userId,
    };
    try {
      final response =
          await _apiService.postResponse('view-assigned-projects/', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => ExistingProjectResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }
}
