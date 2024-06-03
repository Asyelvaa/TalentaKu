class ClassModel {
  final String id;
  final String name;
  final String teacher;
  final String description;
  final List<String> students;

  ClassModel({
    required this.id,
    required this.name,
    required this.teacher,
    required this.description,
    required this.students,
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