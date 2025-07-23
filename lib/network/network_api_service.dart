import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:salt_ware_tax/network/base_api_service.dart';
import 'package:salt_ware_tax/network/error_exception.dart';

class NetworkApiService extends BaseApiService {
  Future postResponse(String url, Map<String, String> jsonBody) async {
    dynamic responseJson;
    try {
      final fullUrl = baseUrl + url;
      print("ServerResponse: $fullUrl");
      jsonBody.forEach((key, value) {
        print("ServerResponse: $key: $value");
      });

      final response =
          await http.post(Uri.parse(baseUrl + url), body: jsonBody);
      responseJson = returnResponse(response);
      // print("ServerResponse: ${response.statusCode}");
      // print("ServerResponse: ${response.body}");
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      print(e);
    }
    return responseJson;
  }

  Future postOcrResponse(String url, Map<String, String> jsonBody) async {
    dynamic responseJson;
    try {
      final response =
          await http.post(Uri.parse(ocrBaseUrl + url), body: jsonBody);
      responseJson = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      print(e);
    }
    return responseJson;
  }

  Future<dynamic> getResponse(
      String url, Map<String, String> queryParams) async {
    dynamic responseJson;
    try {
      final uri = Uri.parse(baseUrl + url);
      final fullUrl = "$uri&${Uri(queryParameters: queryParams).query}";
      final response = await http.get(Uri.parse(fullUrl));
      responseJson = returnResponse(response);
      print("ServerResponse: ${response.statusCode}");
      print("ServerResponse: ${response.body}");
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic responseJson = json.decode(response.body);
        return responseJson;
      case 400:
        throw BadRequestException(response.toString());
      case 401:
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while communication with server' +
                ' with status code : ${response.statusCode}');
    }
  }
}
