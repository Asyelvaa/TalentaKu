import 'package:flutter_talentaku/domain/models/class_model.dart';

class UserModel {
  int id;
  String name;
  String email;
  String identificationNumber;
  String address;
  String birthInformation;
  String? photo;
  List<String> roles;
  List<GradeModel> grades;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.identificationNumber,
    required this.address,
    required this.birthInformation,
    this.photo,
    required this.roles,
    required this.grades,
  });

  // factory UserModel.fromJson(Map<String, dynamic> json) {
  //   return UserModel(
  //     id: json['id'],
  //     name: json['name'],
  //     email: json['email'],
  //     identificationNumber: json['nomor_induk'],
  //     address: json['address'],
  //     birthDate: json['birth_date'],
  //     photo: json['photo'],
  //     roles: List<String>.from(json['roles']),
  //     grades: (json['grades'] as List)
  //         .map((gradeJson) => GradeModel.fromJson(gradeJson))
  //         .toList(),
  //   );
  // }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
    id: json['user']['id'],
    name: json['user']['name'],
    email: json['user']['email'], 
    identificationNumber: json['user']['identification_number'],
    address: json['user']['address'],
    birthInformation: json['user']['birth_information'],
    photo: json['user']['photo'],
    roles: List<String>.from(json['roles'] ?? []),
    grades: _parseGrades(json['grades']),
  );
  }

  static List<GradeModel> _parseGrades(dynamic gradesJson) {
    if (gradesJson is String && gradesJson == "User didn't have any class") {
      return []; 
    } else if (gradesJson is List) {
      return gradesJson.map((gradeJson) => GradeModel.fromJson(gradeJson)).toList();
    } else {
      return [];
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'user': {
        'id': id,
        'name': name,
        'email': email,
        'identification_number': identificationNumber,
        'address': address,
        'photo': photo,
        'birth_information': birthInformation,
      },
      'roles': roles,
      'grades': grades,
    };
  }
}
