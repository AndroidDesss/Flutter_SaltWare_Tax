class NewUserVerificationResponse {
  final String otp;

  NewUserVerificationResponse({required this.otp});
  factory NewUserVerificationResponse.fromJson(Map<String, dynamic> json) {
    return NewUserVerificationResponse(otp: json['otp']);
  }
}
