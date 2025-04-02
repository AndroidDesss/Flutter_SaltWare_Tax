class NameResponse {
  final String id;
  final String firstName;
  final String lastName;
  final String userId;
  final String isDeleted;

  NameResponse(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.userId,
      required this.isDeleted});

  // Factory method to convert JSON to UserData object
  factory NameResponse.fromJson(Map<String, dynamic> json) {
    return NameResponse(
        id: json['id'],
        firstName: json['first_name'],
        lastName: json['last_name'],
        userId: json['user_id'],
        isDeleted: json['is_deleted']);
  }
}
