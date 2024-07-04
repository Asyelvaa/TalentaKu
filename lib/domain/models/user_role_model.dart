class UserRoleModel {
  final List<String> roles;

  UserRoleModel({required this.roles});

  factory UserRoleModel.fromJson(List<dynamic> json) {
    return UserRoleModel(
      roles: json.cast<String>(),
    );
  }
}