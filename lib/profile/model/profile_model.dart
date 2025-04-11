class ProfileResponse {
  final String id;
  final String password;
  final String phone;
  final String email;
  final String isActive;
  final String isAdmin;
  final String isDeleted;

  ProfileResponse(
      {required this.id,
      required this.password,
      required this.phone,
      required this.email,
      required this.isActive,
      required this.isAdmin,
      required this.isDeleted});

  // Factory method to convert JSON to UserData object
  factory ProfileResponse.fromJson(Map<String, dynamic> json) {
    return ProfileResponse(
        id: json['id'],
        password: json['password'],
        phone: json['phone'],
        email: json['email'],
        isActive: json['is_active'],
        isAdmin: json['is_admin'],
        isDeleted: json['is_deleted']);
  }
}
