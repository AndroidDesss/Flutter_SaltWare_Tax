class LoginResponse {
  final String id;
  final String userName;
  final String password;
  final String lastLogin;
  final String phone;
  final String email;
  final String isActive;
  final String isAdmin;
  final String loginType;
  final String companyName;
  final String firstName;
  final String lastName;
  final String taxPayerId;
  final String createdDate;
  final String isDeleted;

  LoginResponse({
    required this.id,
    required this.userName,
    required this.password,
    required this.lastLogin,
    required this.phone,
    required this.email,
    required this.isActive,
    required this.isAdmin,
    required this.loginType,
    required this.companyName,
    required this.firstName,
    required this.lastName,
    required this.taxPayerId,
    required this.createdDate,
    required this.isDeleted,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      id: json['id'] ?? '',
      userName: json['user_name'] ?? '',
      password: json['password'] ?? '',
      lastLogin: json['last_login'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      isActive: json['is_active'] ?? '',
      isAdmin: json['is_admin'] ?? '',
      loginType: json['login_type'] ?? '',
      companyName: json['company'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      taxPayerId: json['tax_payer_id'] ?? '',
      createdDate: json['created_date'] ?? '',
      isDeleted: json['is_deleted'] ?? '',
    );
  }
}
