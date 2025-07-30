class ForgotPasswordResponse {
  final String? otp;
  final String? errmsg;

  ForgotPasswordResponse({this.otp, this.errmsg});

  // Factory method to convert JSON to UserData object
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponse(otp: json['otp'], errmsg: json['errmsg']);
  }
}
