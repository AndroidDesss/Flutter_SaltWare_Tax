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
          await _apiService.postResponse('get_batch_based_user_id', body);

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
