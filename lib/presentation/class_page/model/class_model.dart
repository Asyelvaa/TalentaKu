class ClassModel {
  final String id;
  final String name;
  final String teacher;
  final String description;
  final List<String> students;
  bool isActive;

  ClassModel({
    required this.id,
    required this.name,
    required this.teacher,
    required this.description,
    required this.students,
    this.isActive = true,
  }); 

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'],
      name: json['name'],
      teacher: json['teacher'],
      description: json['description'],
      students: List<String>.from(json['students']),
    );
  }
}