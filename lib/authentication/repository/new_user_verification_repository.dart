import 'package:salt_ware_tax/authentication/model/new_user_verification_model.dart';
import 'package:salt_ware_tax/authentication/model/verify_user_model.dart';
import 'package:salt_ware_tax/network/api_response.dart';
import 'package:salt_ware_tax/network/network_api_service.dart';

class NewUserVerificationRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<CommonApiResponse<NewUserVerificationResponse>> getVerificationOtp(
      String phoneNumber) async {
    Map<String, String> body = {'phone': phoneNumber};
    try {
      final response = await _apiService.postResponse('send-signup-otp/', body);

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
      String userName,
      String password,
      String email,
      String phoneNumber,
      String loginType,
      String firstName,
      String lastName,
      String companyName) async {
    Map<String, String> body = {
      'username': userName,
      'password': password,
      'email': email,
      'phone': phoneNumber,
      'user_type': loginType,
      'first_name': firstName,
      'last_name': lastName,
      'tax_payer_id': '1234567890',
      'company_name': companyName,
    };
    try {
      final response = await _apiService.postResponse('signup/', body);

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
