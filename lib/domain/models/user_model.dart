import 'package:flutter_talentaku/domain/models/class_model.dart';

class UserModel {
  int? id;
  String? name;
  String? email;
  String? identificationNumber;
  String? address;
  String? birthInformation;
  String? photo;
  List<String>? roles;
  List<String>? grades;

  UserModel({
     this.id,
     this.name,
     this.email,
     this.identificationNumber,
     this.address,
     this.birthInformation,
    this.photo,
     this.roles,
    this.grades,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // final baseUrlPhotoProfile = "https://talentaku.site/image/profile/";
    final data = json['data'];

    return UserModel(
      id: data['id'],
      name: data['name'] ,
      email: data['email'],
      identificationNumber: data['identification_number'],
      address: data['address'] ,
      birthInformation: data['birth_information'],
      photo:  data['photo'],
      roles: List<String>.from(data['roles']),
      grades: List<String>.from(data['grades']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'id': id,
        'name': name,
        'email': email,
        'identification_number': identificationNumber,
        'address': address,
        'birth_information': birthInformation,
        'photo': photo,
        'roles': roles,
        'grades': grades,
      }
    };
  }
}
