import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:salt_ware_tax/documents_process/model/scanned_documents_model.dart';
import 'package:salt_ware_tax/network/api_response.dart';

class ScannedDocumentsRepository {
  final String _url =
      'https://saltwaretax.desss-portfolio.com/dynamic/dynamicapi.php?action=multiple_image';

  // Post multiple files to the server
  Future<CommonApiResponse<ScannedDocumentsResponse>> postScannedDocuments(
    String description,
    String userId,
    List<File> files,
  ) async {
    try {
      var uri = Uri.parse(_url);
      var request = http.MultipartRequest('POST', uri);
      request.fields['description'] = description;
      request.fields['user_id'] = userId;

      // Adding files
      for (var file in files) {
        var fileStream =
            await http.MultipartFile.fromPath('files[]', file.path);
        request.files.add(fileStream);
      }

      var response = await request.send();
      print('ServerResponse: ${response.statusCode}');
      print('ServerResponse: ${response}');
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        Map<String, dynamic> responseJson = json.decode(responseBody);
        return CommonApiResponse.fromJson(
          responseJson,
          (item) => ScannedDocumentsResponse.fromJson(item),
        );
      } else {
        throw Exception('Failed to upload files');
      }
    } catch (e) {
      print('ServerResponse: ${e.toString()}');
      rethrow;
    }
  }
}
