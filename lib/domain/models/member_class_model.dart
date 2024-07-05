class MemberClassModel {
  int id;
  String name;
  String photo;

  MemberClassModel({
    required this.id,
    required this.name,
    required this.photo,
    
  });
  factory MemberClassModel.fromJson(Map<String, dynamic> json) {
    return MemberClassModel(
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
