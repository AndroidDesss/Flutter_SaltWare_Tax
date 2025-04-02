import 'package:salt_ware_tax/network/api_response.dart';
import 'package:salt_ware_tax/network/network_api_service.dart';
import 'package:salt_ware_tax/profile/model/name_model.dart';
import 'package:salt_ware_tax/profile/model/profile_model.dart';

class ProfileRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<CommonApiResponse<ProfileResponse>> getProfileDetails(
      String userId) async {
    Map<String, String> body = {
      'table': 'accounts_myuser',
      'id': userId,
    };
    try {
      final response = await _apiService.postResponse('read', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => ProfileResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonApiResponse<NameResponse>> getNameDetails(String userId) async {
    Map<String, String> body = {
      'table': 'accounts_profile',
      'user_id': userId,
    };
    try {
      final response = await _apiService.postResponse('read', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => NameResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }
}
