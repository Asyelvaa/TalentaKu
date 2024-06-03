class UserModel {
  final String id;
  final String name;
  final String email;
  final String birthDate;
  final String photoProfile;
  final String address;
  final String role;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.birthDate,
    required this.photoProfile,
    required this.address,
    required this.role,
  }); 

}

List<UserModel> mockUserList = [
  UserModel(
    id: "1",
    name: "Sekar Annisa",
    email: "sekar@example.com",
    birthDate: "1990-05-15",
    photoProfile: "assets/images/student.png",
    address: "Kuman rt 9 rw 1, kec. Batang, kab. Batang",
    role: "teacher",
  ),
  UserModel(
    id: "2",
    name: "Jane Smith",
    email: "jane.smith@example.com",
    birthDate: "1985-08-22",
    photoProfile: "assets/images/student.png",
    address: "Kuman rt 9 rw 1, kec. Batang, kab. Batang",
    role: "student",
  ),
];