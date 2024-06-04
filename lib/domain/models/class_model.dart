class ClassModel {
  final String id;
  final String name;
  final String teacher;
  final String description;
  bool isActive;

  ClassModel({
    required this.id,
    required this.name,
    required this.teacher,
    required this.description,
    this.isActive = true,
  }); 

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'],
      name: json['name'],
      teacher: json['teacher'],
      description: json['description'],
    );
  }
}