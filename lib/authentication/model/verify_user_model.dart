class VerifyUserResponse {
  final String? success;
  final int? user_id;
  final String? usertype;
  final String? errmsg;

  VerifyUserResponse({this.success, this.user_id, this.usertype, this.errmsg});
  factory VerifyUserResponse.fromJson(Map<String, dynamic> json) {
    return VerifyUserResponse(
        success: json['success'],
        user_id: json['user_id'],
        usertype: json['usertype'],
        errmsg: json['errmsg']);
  }
}
