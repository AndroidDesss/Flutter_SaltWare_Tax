class CheckUserResponse {
  final String? success;
  final String? errmsg;

  CheckUserResponse({this.success, this.errmsg});

  factory CheckUserResponse.fromJson(Map<String, dynamic> json) {
    return CheckUserResponse(success: json['success'], errmsg: json['errmsg']);
  }
}
