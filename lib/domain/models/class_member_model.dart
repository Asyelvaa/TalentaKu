class ClassMemberModel {
  int? id;
  String? name;
  String? email;
  String? identificationNumber;
  String? address;
  String? photo;
  String? birthInformation;
  List<String>? roles;
  List<String>? grades;

  ClassMemberModel({
    this.id,
    this.name,
    this.email,
    this.identificationNumber,
    this.address,
    this.photo,
    this.birthInformation,
    this.roles,
    this.grades,
  });

  factory ClassMemberModel.fromJson(Map<String, dynamic> json) {
    const baseurl = "https://talentaku.site/image/profile/";
    return ClassMemberModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      identificationNumber: json['identification_number'] ?? '',
      address: json['address'] ?? '',
      photo:json['photo'] != null ? baseurl + json['photo'] : null,
      birthInformation: json['birth_information'] ?? '',
      roles: List<String>.from(json['roles'] ?? []),
      grades: List<String>.from(json['grades'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'identification_number': identificationNumber,
      'address': address,
      'photo': photo,
      'birth_information': birthInformation,
      'roles': roles,
      'grades': grades,
    };
  }
}
