class Task {
  String? title;
  String? startDate;
  String? endDate;
  List<String>? desc;
  List<Media>? media;
  List<Link>? links;
  int? teacherId;
  int? gradeId;
  int? id;

  Task({
     this.title,
     this.startDate,
     this.endDate,
     this.desc,
     this.media,
     this.links,
     this.teacherId,
     this.gradeId,
     this.id,
  });
  
   factory Task.fromJson(Map<String, dynamic> json) => Task(
    title: json["title"] as String?,
    startDate: json["start_date"] as String?,
    endDate: json["end_date"] as String?,
    desc: (json["desc"] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
    media: (json["media"] as List<dynamic>?)?.map((x) => Media.fromJson(x)).toList() ?? [],
    links: (json["links"] as List<dynamic>?)?.map((x) => Link.fromJson(x)).toList() ?? [],
    teacherId: json["teacher"]?["id"] as int?,
    gradeId: json["grade"]?["id"] as int?,
    id: json["id"] as int?,
  );

  Map<String, dynamic> toJson() => {
        "title": title,
        "start_date": startDate,
        "end_date": endDate,
        "desc": desc,
        "media": media?.map((x) => x.toJson()).toList(),
        "links": links?.map((x) => x.toJson()).toList(),
        "teacher_id": teacherId,
        "grade_id": gradeId,
        "id": id,
      };
}

class Media {
  int id;
  String fileName;

  Media({
    required this.id,
    required this.fileName,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        fileName: json["file_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file_name": fileName,
      };
}

class Link {
  String taskId;
  String url;
  int id;

  Link({
    required this.taskId,
    required this.url,
    required this.id,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        taskId: json["task_id"],
        url: json["url"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "task_id": taskId,
        "url": url,
        "id": id,
      };
}