class LoginResponse {
  final String? success;
  final int? userId;
  final String? userType;
  final String? userName;
  final String? email;
  final String? phone;
  final String? firstName;
  final String? lastName;
  final String? errmsg;

  LoginResponse(
      {this.success,
      this.userId,
      this.userType,
      this.userName,
      this.email,
      this.phone,
      this.firstName,
      this.lastName,
      this.errmsg});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        success: json['success'] ?? '',
        userId: json['user_id'] ?? '',
        userType: json['user_type'] ?? '',
        userName: json['username'] ?? '',
        email: json['email'] ?? '',
        phone: json['phone'] ?? '',
        firstName: json['first_name'] ?? '',
        lastName: json['last_name'] ?? '',
        errmsg: json['errmsg'] ?? '');
  }
}
