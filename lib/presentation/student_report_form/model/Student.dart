class Student {
  final int id;
  final String name;
  final String? photo;

  Student({required this.id, required this.name, this.photo});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      name: json['name'],
      photo: json['photo'],
    );
  }
}
