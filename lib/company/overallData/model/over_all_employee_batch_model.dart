class OverAllEmployeeBatchResponse {
  final int? employeeId;
  final String employeeName;
  final List<BatchData> batches;

  OverAllEmployeeBatchResponse({
    required this.employeeId,
    required this.employeeName,
    required this.batches,
  });

  factory OverAllEmployeeBatchResponse.fromJson(Map<String, dynamic> json) {
    return OverAllEmployeeBatchResponse(
      employeeId: json['employee_id'],
      employeeName: json['employee_name'],
      batches: List<BatchData>.from(
        json['batches'].map((x) => BatchData.fromJson(x)),
      ),
    );
  }
}

class BatchData {
  final int batchId;
  final String batchName;
  final List<String> images;
  final String pdfUrl;

  BatchData({
    required this.batchId,
    required this.batchName,
    required this.images,
    required this.pdfUrl,
  });

  factory BatchData.fromJson(Map<String, dynamic> json) {
    return BatchData(
      batchId: json['batch_id'],
      batchName: json['batch_name'],
      images: List<String>.from(json['images']),
      pdfUrl: json['pdf_url'],
    );
  }
}
