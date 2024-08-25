class UserModel {
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

  UserModel(
      {this.id,
      this.status,
      this.username,
      this.name,
      this.nomorInduk,
      this.address,
      this.photo,
      this.birthInformation,
      this.roles,
      this.grades});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    username = json['username'];
    name = json['name'];
    nomorInduk = json['nomor_induk'];
    address = json['address'];
    photo = json['photo'];
    birthInformation = json['birth_information'];
    roles = (json['roles'] as List).cast<String>();
    grades = (json['grades'] as List).cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['username'] = this.username;
    data['name'] = this.name;
    data['nomor_induk'] = this.nomorInduk;
    data['address'] = this.address;
    data['photo'] = this.photo;
    data['birth_information'] = this.birthInformation;
    data['roles'] = this.roles;
    data['grades'] = this.grades;
    return data;
  }
}
