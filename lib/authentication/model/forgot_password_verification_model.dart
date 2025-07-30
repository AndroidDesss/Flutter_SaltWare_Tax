class ForgotPasswordVerificationResponse {
  final String? otp;
  final String? errmsg;

  ForgotPasswordVerificationResponse({this.otp, this.errmsg});

  // Factory method to convert JSON to UserData object
  factory ForgotPasswordVerificationResponse.fromJson(
      Map<String, dynamic> json) {
    return ForgotPasswordVerificationResponse(
        otp: json['otp'], errmsg: json['errmsg']);
  }
}
