class ExistingDocumentResponse {
  final String id;
  final String createdDate;
  final String description;
  final String userId;
  final String firstName;

  ExistingDocumentResponse(
      {required this.id,
      required this.createdDate,
      required this.description,
      required this.userId,
      required this.firstName});

  // Factory method to convert JSON to UserData object
  factory ExistingDocumentResponse.fromJson(Map<String, dynamic> json) {
    return ExistingDocumentResponse(
        id: json['id'],
        createdDate: json['created_date'],
        description: json['description'],
        userId: json['user_id'],
        firstName: json['first_name']);
  }
}
