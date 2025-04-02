class PdfResponse {
  final String id;
  final String pdfPath;
  final String batchId;

  PdfResponse({required this.id, required this.pdfPath, required this.batchId});

  // Factory method to convert JSON to UserData object
  factory PdfResponse.fromJson(Map<String, dynamic> json) {
    return PdfResponse(
        id: json['id'], pdfPath: json['pdf_paths'], batchId: json['batch_id']);
  }
}
