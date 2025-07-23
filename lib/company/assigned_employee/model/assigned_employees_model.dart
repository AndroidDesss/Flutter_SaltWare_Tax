class AssignedEmployeesResponse {
  final String id;
  final String createdDate;
  final String password;
  final String phone;
  final String email;
  final String isActive;
  final String isAdmin;
  final String firstName;
  final String lastName;

  AssignedEmployeesResponse({
    required this.id,
    required this.createdDate,
    required this.password,
    required this.phone,
    required this.email,
    required this.isActive,
    required this.isAdmin,
    required this.firstName,
    required this.lastName,
  });

  factory AssignedEmployeesResponse.fromJson(Map<String, dynamic> json) {
    return AssignedEmployeesResponse(
      id: json['id'] ?? '',
      createdDate: json['created_date'] ?? '',
      password: json['password'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      isActive: json['is_active'] ?? '',
      isAdmin: json['is_admin'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
    );
  }
}
