class NewUserVerificationResponse {
  final String? otp;
  final String? errmsg;

  NewUserVerificationResponse({this.otp, this.errmsg});
  factory NewUserVerificationResponse.fromJson(Map<String, dynamic> json) {
    return NewUserVerificationResponse(
        otp: json['otp'], errmsg: json['errmsg']);
  }
}
