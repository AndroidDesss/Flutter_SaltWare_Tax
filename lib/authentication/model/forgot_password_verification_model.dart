class ForgotPasswordVerificationResponse {
  final String otp;

  ForgotPasswordVerificationResponse({required this.otp});

  // Factory method to convert JSON to UserData object
  factory ForgotPasswordVerificationResponse.fromJson(
      Map<String, dynamic> json) {
    return ForgotPasswordVerificationResponse(otp: json['otp']);
  }
}
