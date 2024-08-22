class ClassMemberModel {
  int? id;
  String? status;
  String? username;
  String? name;
  String? nomorInduk;
  String? address;
  String? photo;
  String? birthInformation;
  List<String>? roles;
  List<String>? grades;

  ClassMemberModel({
    this.id,
    this.status,
    this.username,
    this.name,
    this.nomorInduk,
    this.address,
    this.photo,
    this.birthInformation,
    this.roles,
    this.grades,
  });

  factory ClassMemberModel.fromJson(Map<String, dynamic> json) {
    return ClassMemberModel(
      id: json['id'],
      status: json['status'],
      username: json['username'],
      name: json['name'],
      nomorInduk: json['nomor_induk'],
      address: json['address'],
      photo: json['photo'],
      birthInformation: json['birth_information'],
      roles: json['roles'] != null ? List<String>.from(json['roles']) : [],
      grades: json['grades'] != null ? List<String>.from(json['grades']) : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'username': username,
      'name': name,
      'nomor_induk': nomorInduk,
      'address': address,
      'photo': photo,
      'birth_information': birthInformation,
      'roles': roles,
      'grades': grades,
    };
  }
}
