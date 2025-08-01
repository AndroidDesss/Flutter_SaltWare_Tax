import 'package:salt_ware_tax/documents_process/model/existing_document_model.dart';
import 'package:salt_ware_tax/network/api_response.dart';
import 'package:salt_ware_tax/network/network_api_service.dart';

class ExistingDocumentRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<CommonApiResponse<ExistingDocumentResponse>> getFoldersList(
      String userId) async {
    Map<String, String> body = {
      'user_id': userId,
    };
    try {
      final response =
          await _apiService.postResponse('view-batches-individual/', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => ExistingDocumentResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonApiResponse<ExistingDocumentResponse>>
      getFoldersBasedOnProjectList(String userId, String projectId) async {
    Map<String, String> body = {
      'user_id': userId,
      'project_id': projectId,
    };
    try {
      final response =
          await _apiService.postResponse('view-batches-employee/', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => ExistingDocumentResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }
}
