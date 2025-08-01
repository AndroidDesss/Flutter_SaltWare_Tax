class OverAllUnAssignedEmployeeResponse {
  final int employeeId;
  final String userName;
  final String email;

  OverAllUnAssignedEmployeeResponse({
    required this.employeeId,
    required this.userName,
    required this.email,
  });

  factory OverAllUnAssignedEmployeeResponse.fromJson(
      Map<String, dynamic> json) {
    return OverAllUnAssignedEmployeeResponse(
      employeeId: json['employee_id'],
      userName: json['username'],
      email: json['email'],
    );
  }
}
