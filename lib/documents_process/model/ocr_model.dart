class OcrResponse {
  final String email;
  final String categoryName;
  final String url;

  OcrResponse(
      {required this.email, required this.categoryName, required this.url});

  // Factory method to convert JSON to UserData object
  factory OcrResponse.fromJson(Map<String, dynamic> json) {
    return OcrResponse(
      email: json['email'],
      categoryName: json['category_name'],
      url: json['url'],
    );
  }
}
