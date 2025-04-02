class ChangePasswordResponse {
  final String msg;

  ChangePasswordResponse({required this.msg});

  // Factory method to convert JSON to UserData object
  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(msg: json['msg']);
  }
}
