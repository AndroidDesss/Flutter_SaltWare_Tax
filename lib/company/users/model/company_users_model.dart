class CompanyUsersResponse {
  final int employeeId;
  final String userName;
  final String email;
  final String phone;
  final String firstName;
  final String lastName;

  CompanyUsersResponse({
    required this.employeeId,
    required this.userName,
    required this.email,
    required this.phone,
    required this.firstName,
    required this.lastName,
  });

  // Factory method to convert JSON to UserData object
  factory CompanyUsersResponse.fromJson(Map<String, dynamic> json) {
    return CompanyUsersResponse(
      employeeId: json['employee_id'],
      userName: json['username'],
      email: json['email'],
      phone: json['phone'],
      firstName: json['first_name'],
      lastName: json['last_name'],
    );
  }
}
