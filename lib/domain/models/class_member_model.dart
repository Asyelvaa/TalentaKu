class ClassMemberModel {
  int id;
  String name;
  String photo;

  ClassMemberModel({
    required this.id,
    required this.name,
    required this.photo,
    
  });
  factory ClassMemberModel.fromJson(Map<String, dynamic> json) {
    return ClassMemberModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      photo: json['photo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
    };
  }
}
