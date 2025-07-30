class CreateProjectResponse {
  final String? success;
  final int? userId;
  final String? userType;
  final String? companyName;
  final int? projectId;
  final String? projectName;
  final String? errmsg;

  CreateProjectResponse(
      {this.success,
      this.userId,
      this.userType,
      this.companyName,
      this.projectId,
      this.projectName,
      this.errmsg});

  // Factory method to convert JSON to UserData object
  factory CreateProjectResponse.fromJson(Map<String, dynamic> json) {
    return CreateProjectResponse(
        success: json['success'],
        userId: json['user_id'],
        userType: json['user_type'],
        companyName: json['company_name'],
        projectId: json['project_id'],
        projectName: json['project_name'],
        errmsg: json['errmsg']);
  }
}
