class ExistingDocumentResponse {
  final int batchId;
  final String userType;
  final String batchName;
  final List<String> images;
  final String pdfUrl;
  final int? projectId;

  ExistingDocumentResponse({
    required this.batchId,
    required this.userType,
    required this.batchName,
    required this.images,
    required this.pdfUrl,
    this.projectId,
  });

  factory ExistingDocumentResponse.fromJson(Map<String, dynamic> json) {
    return ExistingDocumentResponse(
      batchId: json['batch_id'],
      userType: json['user_type'],
      batchName: json['batch_name'],
      images: List<String>.from(json['images']),
      pdfUrl: json['pdf_url'],
      projectId: json['project_id'],
    );
  }
}
