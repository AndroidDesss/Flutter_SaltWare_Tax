class AddEmployeeModelResponse {
  final String? success;
  final int? employeeId;
  final String? userName;
  final String? companyName;
  final int? userId;
  final String? errmsg;

  AddEmployeeModelResponse({
    this.success,
    this.employeeId,
    this.userName,
    this.companyName,
    this.userId,
    this.errmsg,
  });
  factory AddEmployeeModelResponse.fromJson(Map<String, dynamic> json) {
    return AddEmployeeModelResponse(
        success: json['success'],
        employeeId: json['employee_id'],
        userName: json['username'],
        companyName: json['company_name'],
        userId: json['user_id'] ?? '',
        errmsg: json['errmsg'] ?? '');
  }
}
