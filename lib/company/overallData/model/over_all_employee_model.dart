class OverAllEmployeeResponse {
  final int projectId;
  final String projectName;
  final List<EmployeeData> assignedEmployees;

  OverAllEmployeeResponse({
    required this.projectId,
    required this.projectName,
    required this.assignedEmployees,
  });

  factory OverAllEmployeeResponse.fromJson(Map<String, dynamic> json) {
    return OverAllEmployeeResponse(
      projectId: json['project_id'],
      projectName: json['project_name'],
      assignedEmployees: List<EmployeeData>.from(
        json['assigned_employees'].map((x) => EmployeeData.fromJson(x)),
      ),
    );
  }
}

class EmployeeData {
  final int employeeId;
  final String employeeName;
  final String email;
  final String type;

  EmployeeData({
    required this.employeeId,
    required this.employeeName,
    required this.email,
    required this.type,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) {
    return EmployeeData(
      employeeId: json['employee_id'],
      employeeName: json['employee_name'],
      email: json['email'],
      type: json['type'],
    );
  }
}
