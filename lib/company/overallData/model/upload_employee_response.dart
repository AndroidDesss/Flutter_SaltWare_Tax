class UploadEmployeeResponse {
  final String message;
  final String companyName;
  final int projectId;
  final String projectName;
  final List<EmployeeData> assignments;
  final int userId;

  UploadEmployeeResponse({
    required this.message,
    required this.companyName,
    required this.projectId,
    required this.projectName,
    required this.assignments,
    required this.userId,
  });

  factory UploadEmployeeResponse.fromJson(Map<String, dynamic> json) {
    return UploadEmployeeResponse(
      message: json['message'],
      companyName: json['company_name'],
      projectId: json['project_id'],
      projectName: json['project_name'],
      assignments: List<EmployeeData>.from(
        json['assignments'].map((x) => EmployeeData.fromJson(x)),
      ),
      userId: json['user_id'],
    );
  }
}

class EmployeeData {
  final int employeeId;
  final String status;

  EmployeeData({required this.employeeId, required this.status});

  factory EmployeeData.fromJson(Map<String, dynamic> json) {
    return EmployeeData(
      employeeId: json['employee_id'],
      status: json['status'],
    );
  }
}
