class Program {
  final int id;
  final String name;
  final List<String> desc;
  final List<String>? photos;

  Program({
    required this.id,
    required this.name,
    required this.desc,
    this.photos,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Not Found',
      desc: List<String>.from(json['desc'] ?? []),
      photos: List<String>.from(json['photo'] ?? []),
    );
  }
}