class Task {
  String title;
  String startDate;
  String endDate;
  String desc;
  List<Media> media;
  List<Link> links;
  int teacherId;
  int gradeId;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  Task({
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.desc,
    required this.media,
    required this.links,
    required this.teacherId,
    required this.gradeId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });
  
   factory Task.fromJson(Map<String, dynamic> json) => Task(
        title: json["title"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        desc: json["desc"],
        media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
        links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
        teacherId: json["teacher_id"],
        gradeId: json["grade_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "start_date": startDate,
        "end_date": endDate,
        "desc": desc,
        "media": List<dynamic>.from(media.map((x) => x.toJson())),
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
        "teacher_id": teacherId,
        "grade_id": gradeId,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}

class Media {
  int id;
  String originalName;
  dynamic filePath;

  Media({
    required this.id,
    required this.originalName,
    this.filePath,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        originalName: json["original_name"],
        filePath: json["file_path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "original_name": originalName,
        "file_path": filePath,
      };
}

class Link {
  int taskId;
  String link;
  DateTime updatedAt;
  DateTime createdAt;
  int id;

  Link({
    required this.taskId,
    required this.link,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        taskId: json["task_id"],
        link: json["link"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "task_id": taskId,
        "link": link,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}