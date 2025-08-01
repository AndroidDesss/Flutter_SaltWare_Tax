class VerifyUserResponse {
  final String? success;
  final int? userId;
  final String? usertype;
  final String? errmsg;

  VerifyUserResponse({this.success, this.userId, this.usertype, this.errmsg});
  factory VerifyUserResponse.fromJson(Map<String, dynamic> json) {
    return VerifyUserResponse(
        success: json['success'],
        userId: json['user_id'],
        usertype: json['usertype'],
        errmsg: json['errmsg']);
  }
}
