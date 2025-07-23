import 'package:salt_ware_tax/authentication/model/login_model.dart';
import 'package:salt_ware_tax/network/api_response.dart';
import 'package:salt_ware_tax/network/network_api_service.dart';

class UsersRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<CommonApiResponse<LoginResponse>> getCompanyBasedUsers(
      String companyName) async {
    Map<String, String> body = {
      'company': companyName,
    };
    try {
      final response =
          await _apiService.postResponse('get_company_user_details', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => LoginResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }
}
