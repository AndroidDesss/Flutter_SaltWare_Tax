class LoginResponse {
  final String success;
  final int userId;
  final String userType;
  final String userName;
  final String email;
  final String phone;

  LoginResponse(
      {required this.success,
      required this.userId,
      required this.userType,
      required this.userName,
      required this.email,
      required this.phone});

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
        success: json['success'] ?? '',
        userId: json['user_id'] ?? '',
        userType: json['user_type'] ?? '',
        userName: json['username'] ?? '',
        email: json['email'] ?? '',
        phone: json['phone'] ?? '');
  }
}
