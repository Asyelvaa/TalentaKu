class UserModel {
  final int id;
  final String name;
  final String desc;
  final String? photo;
  final String category_id;
  final String createdAt;
  final String updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.desc,
    required this.photo,
    required this.category_id,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      photo: json['photo'],
      category_id: json['category_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class ContentModel {
  String title;
  List<String> desc;
  List<SubContentModel> subContent;

  ContentModel({
    required this.title,
    required this.desc,
    required this.subContent,
  });

  factory ContentModel.fromJson(Map<String, dynamic> json) {
    var descFromJson = json['desc']['desc'] != null
        ? List<String>.from(json['desc']['desc'])
        : <String>[];

    var subContentFromJson = json['desc'] is List
        ? (json['desc'] as List).map((item) => SubContentModel.fromJson(item)).toList()
        : <SubContentModel>[];

    return ContentModel(
      title: json['title'],
      desc: descFromJson,
      subContent: subContentFromJson,
    );
  }
}

class SubContentModel {
  String title;
  List<String> desc;

  SubContentModel({
    required this.title,
    required this.desc,
  });

  factory SubContentModel.fromJson(Map<String, dynamic> json) {
    return SubContentModel(
      title: json['title'],
      desc: List<String>.from(json['desc']),
    );
  }
}
