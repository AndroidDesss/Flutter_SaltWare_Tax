class CheckUserResponse {
  final String msg;

  CheckUserResponse({required this.msg});

  factory CheckUserResponse.fromJson(Map<String, dynamic> json) {
    return CheckUserResponse(msg: json['msg']);
  }
}
