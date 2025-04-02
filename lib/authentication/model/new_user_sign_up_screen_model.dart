class NewUserSignUpScreenResponse {
  final String id;
  final String password;
  final String lastLogin;
  final String phone;
  final String email;
  final String isActive;
  final String isAdmin;
  final String createdDate;
  final String isDeleted;

  NewUserSignUpScreenResponse(
      {required this.id,
      required this.password,
      required this.lastLogin,
      required this.phone,
      required this.email,
      required this.isActive,
      required this.isAdmin,
      required this.createdDate,
      required this.isDeleted});

  // Factory method to convert JSON to UserData object
  factory NewUserSignUpScreenResponse.fromJson(Map<String, dynamic> json) {
    return NewUserSignUpScreenResponse(
        id: json['id'],
        password: json['password'],
        lastLogin: json['last_login'],
        phone: json['phone'],
        email: json['email'],
        isActive: json['is_active'],
        isAdmin: json['is_admin'],
        createdDate: json['created_date'],
        isDeleted: json['is_deleted']);
  }
}
