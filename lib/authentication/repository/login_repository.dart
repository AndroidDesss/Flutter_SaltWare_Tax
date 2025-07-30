import 'package:salt_ware_tax/authentication/model/login_model.dart';
import 'package:salt_ware_tax/network/api_response.dart';
import 'package:salt_ware_tax/network/network_api_service.dart';

class LoginRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<CommonApiResponse<LoginResponse>> login(
      String userName, String password) async {
    Map<String, String> body = {'username': userName, 'password': password};
    try {
      final response = await _apiService.postResponse('login/', body);

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
