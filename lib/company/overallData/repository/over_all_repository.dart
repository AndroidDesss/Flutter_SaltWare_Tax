import 'package:salt_ware_tax/company/overallData/model/over_all_data_model.dart';
import 'package:salt_ware_tax/company/project/model/create_project_model.dart';
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
}
