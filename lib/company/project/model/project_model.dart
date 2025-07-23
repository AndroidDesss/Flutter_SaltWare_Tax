class ProjectResponse {
  final String id;
  final String createdDate;
  final String description;
  final String userId;
  final String assignedUser;

  ProjectResponse({
    required this.id,
    required this.createdDate,
    required this.description,
    required this.userId,
    required this.assignedUser,
  });

  // Factory method to convert JSON to UserData object
  factory ProjectResponse.fromJson(Map<String, dynamic> json) {
    return ProjectResponse(
        id: json['id'],
        createdDate: json['created_date'],
        description: json['description'],
        userId: json['user_id'],
        assignedUser: json['assigned_user']);
  }
}
