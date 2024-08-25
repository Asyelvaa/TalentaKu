class Student {
  final int id;
  final String status; // Added this field based on JSON
  final String username; // Added this field based on JSON
  final String name;
  final String? photo;
  final String identificationNumber;
  final String address;
  final String birthInformation;
  final List<String> roles;
  final List<String> grades;

  Student({
    required this.id,
    required this.status, // Added this parameter to the constructor
    required this.username, // Added this parameter to the constructor
    required this.name,
    this.photo,
    required this.identificationNumber,
    required this.address,
    required this.birthInformation,
    required this.roles,
    required this.grades,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      status: json['status'], // Added this line for 'status'
      username: json['username'],
      name: json['name'],
      photo: json['photo'],
      identificationNumber: json['nomor_induk'],
      address: json['address'],
      birthInformation: json['birth_information'],
      roles: List<String>.from(json['roles']),
      grades: List<String>.from(json['grades']),
    );
  }
}
