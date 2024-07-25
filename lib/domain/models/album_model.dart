class Album {
  final int id;
  final String desc;
  final String date;
  final String gradeId;
  final String teacherId;
  final String createdAt;
  final String updatedAt;
  final List<Media> media;

  Album({
    required this.id, 
    required this.desc, 
    required this.date, 
    required this.gradeId,
    required this.teacherId,
    required this.createdAt,
    required this.updatedAt,
    required this.media
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    var mediaList = (json['media'] as List)
        .map((mediaJson) => Media.fromJson(mediaJson))
        .toList();

    return Album(
      id: json['id'],
      desc: json['desc'],
      date: json['date'],
      gradeId: json['grade_id'],
      teacherId: json['teacher_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      media: mediaList,
    );
  }
}

class Media {
  final int id;
  final String filePath;
  final String createdAt;
  final String updatedAt;

  Media({
    required this.id, 
    required this.filePath,
    required this.createdAt,
    required this.updatedAt
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    const String baseUrl = 'https://talentaku.site/api';
    return Media(
      id: json['id'],
      filePath: baseUrl + json['file_path'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
