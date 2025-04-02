class ScannedDocumentsResponse {
  final String msg;

  ScannedDocumentsResponse({required this.msg});

  // Factory method to convert JSON to UserData object
  factory ScannedDocumentsResponse.fromJson(Map<String, dynamic> json) {
    return ScannedDocumentsResponse(msg: json['msg']);
  }
}
