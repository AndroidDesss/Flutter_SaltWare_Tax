class OverAllResponse {
  final int projectId;
  final String projectName;
  final List<EmployeeData> employees;

  OverAllResponse({
    required this.projectId,
    required this.projectName,
    required this.employees,
  });

  factory OverAllResponse.fromJson(Map<String, dynamic> json) {
    return OverAllResponse(
      projectId: json['project_id'],
      projectName: json['project_name'],
      employees: List<EmployeeData>.from(
        json['employees'].map((x) => EmployeeData.fromJson(x)),
      ),
    );
  }
}

class EmployeeData {
  final int employeeId;
  final String employeeName;
  final List<BatchData> batches;

  EmployeeData({
    required this.employeeId,
    required this.employeeName,
    required this.batches,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) {
    return EmployeeData(
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
