import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:salt_ware_tax/documents_process/model/scanned_documents_model.dart';
import 'package:salt_ware_tax/network/api_response.dart';

class ScannedDocumentsRepository {
  final String _url = 'http://pdftotext.zunamelt.com/dynamicapi/create_upload/';

  // Post multiple files to the server
  Future<CommonApiResponse<ScannedDocumentsResponse>> postScannedDocuments(
      String description,
      String userId,
      List<File> files,
      String projectId) async {
    try {
      var uri = Uri.parse(_url);
      var request = http.MultipartRequest('POST', uri);
      request.fields['batch_name'] = description;
      request.fields['project_id'] = projectId;
      request.fields['user_id'] = userId;

      // Adding files
      for (var file in files) {
        var fileStream = await http.MultipartFile.fromPath('images', file.path);
        request.files.add(fileStream);
      }
      for (var file in files) {
        print('ServerResponse:${file.path}');
      }

      print('ServerResponse: Fields:');
      request.fields.forEach((key, value) {
        print('ServerResponse: $key: $value');
      });

// Log all files
      print('ServerResponse: Files:');
      for (var f in request.files) {
        print(
            'ServerResponse: field: ${f.field}, filename: ${f.filename}, contentType: ${f.contentType}');
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
