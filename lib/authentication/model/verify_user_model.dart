class VerifyUserResponse {
  final String errmsg;

  VerifyUserResponse({required this.errmsg});
  factory VerifyUserResponse.fromJson(Map<String, dynamic> json) {
    return VerifyUserResponse(errmsg: json['errmsg']);
  }
}
