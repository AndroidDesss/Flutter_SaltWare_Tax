import 'package:salt_ware_tax/authentication/model/change_password_model.dart';
import 'package:salt_ware_tax/network/api_response.dart';
import 'package:salt_ware_tax/network/network_api_service.dart';

class ChangePasswordRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<CommonApiResponse<ChangePasswordResponse>> changePassword(
      String phoneNumber, String password) async {
    Map<String, String> body = {'phone': phoneNumber, 'new_password': password};
    try {
      final response = await _apiService.postResponse('resetpassword/', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => ChangePasswordResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }
}
