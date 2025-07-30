import 'package:salt_ware_tax/authentication/model/check_user_model.dart';
import 'package:salt_ware_tax/network/api_response.dart';
import 'package:salt_ware_tax/network/network_api_service.dart';

class NewUserSignUpScreenRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<CommonApiResponse<CheckUserResponse>> checkUser(
      String userName, String email, String phoneNumber) async {
    Map<String, String> body = {
      'username': userName,
      'email': email,
      'phone': phoneNumber
    };
    try {
      final response = await _apiService.postResponse('check-user/', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => CheckUserResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }
}
