class ProjectResponse {
  final int projectId;
  final String projectName;

  ProjectResponse({required this.projectId, required this.projectName});

  // Factory method to convert JSON to UserData object
  factory ProjectResponse.fromJson(Map<String, dynamic> json) {
    return ProjectResponse(
        projectId: json['project_id'], projectName: json['project_name']);
  }
}
