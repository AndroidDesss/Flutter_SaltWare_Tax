import 'package:salt_ware_tax/company/users/model/add_employee_model.dart';
import 'package:salt_ware_tax/company/users/model/company_users_model.dart';
import 'package:salt_ware_tax/network/api_response.dart';
import 'package:salt_ware_tax/network/network_api_service.dart';

class UsersRepository {
  final NetworkApiService _apiService = NetworkApiService();

  Future<CommonApiResponse<CompanyUsersResponse>> getCompanyBasedUsers(
      String userId) async {
    Map<String, String> body = {
      'user_id': userId,
    };
    try {
      final response = await _apiService.postResponse('view-employees/', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => CompanyUsersResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CommonApiResponse<AddEmployeeModelResponse>> addNewUser(
      String userName,
      String email,
      String phoneNumber,
      String password,
      String firstName,
      String lastName,
      String userId) async {
    Map<String, String> body = {
      'username': userName,
      'email': email,
      'phone': phoneNumber,
      'password': password,
      'first_name': firstName,
      'last_name': lastName,
      'user_id': userId,
    };
    try {
      final response = await _apiService.postResponse('addemployee/', body);

      if (response != null) {
        return CommonApiResponse.fromJson(
            response, (item) => AddEmployeeModelResponse.fromJson(item));
      } else {
        throw Exception('Invalid response from server');
      }
    } catch (e) {
      rethrow;
    }
  }
}
