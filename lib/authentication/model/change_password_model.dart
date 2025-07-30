class ChangePasswordResponse {
  final String? message;
  final String? usertype;

  ChangePasswordResponse({this.message, this.usertype});

  // Factory method to convert JSON to UserData object
  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(
        message: json['message'], usertype: json['usertype']);
  }
}
