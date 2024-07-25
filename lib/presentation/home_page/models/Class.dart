class Program_Edit {
  final int id;
  final String name;
  final String desc;
 final List<String> photo;  // Should be List<String>
  final int? categoryId;  // Changed to categoryId
  final DateTime createdAt;
  final DateTime updatedAt;

  Program_Edit({
    required this.id,
    required this.name,
    required this.desc,
    required this.photo,
    this.categoryId,  
    
    required this.createdAt,
    required this.updatedAt,
  });

  factory Program_Edit.fromJson(Map<String, dynamic> json) {
    return Program_Edit(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      photo: json['photo'],
      categoryId: json['category_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'desc': desc,
      'photo': photo,
      'category_id': categoryId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
