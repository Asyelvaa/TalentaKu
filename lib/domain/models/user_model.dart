import 'package:flutter_talentaku/domain/models/class_model.dart';

class UserModel {
  int id;
  String name;
  String email;
  String identificationNumber;
  String address;
  String birthDate;
  String? photo;
  List<String> roles;
  List<GradeModel> grades;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.identificationNumber,
    required this.address,
    required this.birthDate,
    this.photo,
    required this.roles,
    required this.grades,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      identificationNumber: json['nomor_induk'],
      address: json['address'],
      birthDate: json['birth_date'],
      photo: json['photo'],
      roles: List<String>.from(json['roles']),
      grades: (json['grades'] as List)
          .map((gradeJson) => GradeModel.fromJson(gradeJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'identificationNumber': identificationNumber,
      'address': address,
      'birthDate': birthDate,
      'photo': photo,
      'roles': roles,
      'grades': grades.map((grade) => grade.toJson()).toList(),
    };
  }
}
