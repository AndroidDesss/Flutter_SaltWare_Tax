class ExistingDocumentResponse {
  final int batchId;
  final String batchName;
  final List<String> images;
  final String pdfUrl;

  ExistingDocumentResponse({
    required this.batchId,
    required this.batchName,
    required this.images,
    required this.pdfUrl,
  });

  factory ExistingDocumentResponse.fromJson(Map<String, dynamic> json) {
    return ExistingDocumentResponse(
      batchId: json['batch_id'],
      batchName: json['batch_name'],
      images: List<String>.from(json['images']),
      pdfUrl: json['pdf_url'],
    );
  }
}
