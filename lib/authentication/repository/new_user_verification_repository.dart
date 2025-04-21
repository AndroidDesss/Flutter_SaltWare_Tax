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
      String userName,
      String password,
      String firstName,
      String lastName,
      String email,
      String phoneNumber,
      String taxPayerId) async {
    Map<String, String> body = {
      'is_active': '1',
      'user_name': userName,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phoneNumber,
      'tax_payer_id': taxPayerId
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
