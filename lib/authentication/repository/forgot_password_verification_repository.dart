import 'package:salt_ware_tax/authentication/model/forgot_password_verification_model.dart';
import 'package:salt_ware_tax/network/api_response.dart';
import 'package:salt_ware_tax/network/network_api_service.dart';

class ForgotPasswordVerificationRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<CommonApiResponse<ForgotPasswordVerificationResponse>>
      getResendVerificationOtp(String phoneNumber) async {
    Map<String, String> body = {'phone': phoneNumber, 'region': '1'};
    try {
      final response = await _apiService.postResponse('otp', body);

      if (response != null) {
        return CommonApiResponse.fromJson(response,
            (item) => ForgotPasswordVerificationResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }
}
