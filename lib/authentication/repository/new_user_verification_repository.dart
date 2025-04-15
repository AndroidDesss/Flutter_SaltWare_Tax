import 'package:salt_ware_tax/authentication/model/new_user_verification_model.dart';
import 'package:salt_ware_tax/authentication/model/verify_user_model.dart';
import 'package:salt_ware_tax/network/api_response.dart';
import 'package:salt_ware_tax/network/network_api_service.dart';

class NewUserVerificationRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<CommonApiResponse<NewUserVerificationResponse>> getVerificationOtp(
      String phoneNumber) async {
    Map<String, String> body = {'region': '1', 'phone': phoneNumber};
    try {
      final response = await _apiService.postResponse('otp1', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => NewUserVerificationResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonApiResponse<VerifyUserResponse>> verifyNewUser(
      String phoneNumber,
      String email,
      String password,
      String firstName) async {
    Map<String, String> body = {
      'is_active': '1',
      'email': email,
      'phone': phoneNumber,
      'password': password,
      'first_name': firstName,
      'last_name': ''
    };
    try {
      final response = await _apiService.postResponse('sign_up', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => VerifyUserResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }
}
