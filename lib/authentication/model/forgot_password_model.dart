class ForgotPasswordResponse {
  final String otp;

  ForgotPasswordResponse({required this.otp});

  // Factory method to convert JSON to UserData object
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(otp: json['otp']);
  }
}
