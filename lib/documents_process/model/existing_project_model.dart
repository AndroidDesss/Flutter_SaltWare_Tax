class ExistingProjectResponse {
  final int projectId;
  final String projectName;
  final String companyName;

  ExistingProjectResponse(
      {required this.projectId,
      required this.projectName,
      required this.companyName});

  factory ExistingProjectResponse.fromJson(Map<String, dynamic> json) {
    return ExistingProjectResponse(
        projectId: json['project_id'],
        projectName: json['project_name'],
        companyName: json['company_name']);
  }
}
