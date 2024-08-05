class Student {
  final int id;
  final String name;
  final String? photo;
  final String email;
  final String identificationNumber;
  final String address;
  final String birthInformation;
  final List<String> roles;
  final List<String> grades;

  Student({
    required this.id,
    required this.name,
    this.photo,
    required this.email,
    required this.identificationNumber,
    required this.address,
    required this.birthInformation,
    required this.roles,
    required this.grades,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      photo: json['photo'],
      email: json['email'],
      identificationNumber: json['identification_number'],
      address: json['address'],
      birthInformation: json['birth_information'],
      roles: List<String>.from(json['roles']),
      grades: List<String>.from(json['grades']),
    );
  }
}
