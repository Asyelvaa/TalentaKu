class UserModel {
  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String nomorInduk;
  final String address;
  final String birthDate;
  final String? photo;
  final String createdAt;
  final String updatedAt;
  final List<String> roles;
  final String grades;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.nomorInduk,
    required this.address,
    required this.birthDate,
    required this.createdAt,
    required this.updatedAt,
    required this.roles,
    required this.grades,
    this.photo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      nomorInduk: json['nomor_induk'],
      address: json['address'],
      birthDate: json['birth_date'],
      photo: json['photo'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      roles: List<String>.from(json['roles']),
      grades: json['grades'],
    );
  }
}
