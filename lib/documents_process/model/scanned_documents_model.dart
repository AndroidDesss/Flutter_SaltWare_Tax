class ScannedDocumentsResponse {
  final String message;
  final String userType;
  final int batchId;
  final String batchName;
  final List<String> imageUrl;
  final String pdfUrl;

  ScannedDocumentsResponse(
      {required this.message,
      required this.userType,
      required this.batchId,
      required this.batchName,
      required this.imageUrl,
      required this.pdfUrl});

  factory ScannedDocumentsResponse.fromJson(Map<String, dynamic> json) {
    return ScannedDocumentsResponse(
      message: json['message'],
      userType: json['user_type'],
      batchId: json['batch_id'],
      batchName: json['batch_name'],
      imageUrl: List<String>.from(json['image_urls']),
      pdfUrl: json['local_pdf_url'],
    );
  }
}
