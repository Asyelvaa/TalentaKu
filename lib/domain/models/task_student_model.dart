

class TaskStudentModel {
  int? taskId;
  bool? haveSubmit;
  String? title;
  DateTime? startDate;
  DateTime? endDate;
  List<String>? desc;
  String? gradeName;
  TeacherModel? teacher;
  List<Media>? media;
  List<Link>? links;

  TaskStudentModel({
    this.taskId,
    this.haveSubmit,
    this.title,
    this.startDate,
    this.endDate,
    this.desc,
    this.gradeName,
    this.teacher,
    this.media,
    this.links,
  });

  factory TaskStudentModel.fromJson(Map<String, dynamic> json) {
    return TaskStudentModel(
      taskId: json['task_id'],
      haveSubmit: json['have_submit'],
      title: json['task']['title'],
      startDate: DateTime.parse(json['task']['start_date']),
      endDate: DateTime.parse(json['task']['end_date']),
      desc: List<String>.from(json['task']['desc']),
      gradeName: json['task']['grade']['name'],
      teacher: TeacherModel.fromJson(json['task']['teacher']),
      media: List<Media>.from(json['task']['media'].map((x) => Media.fromJson(x))) ?? [],
      links: List<Link>.from(json['task']['links'].map((x) => Link.fromJson(x))) ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'task_id': taskId,
      'have_submit': haveSubmit,
      'task': {
        'title': title,
        'start_date': startDate?.toIso8601String(),
        'end_date': endDate?.toIso8601String(),
        'desc': List<dynamic>.from(desc!.map((x) => x)),
        'grade': gradeName,
        'teacher': teacher?.toJson(),
        "media": media?.map((x) => x.toJson()).toList(),
        "links": links?.map((x) => x.toJson()).toList(),
      },
    };
  }
}

class TeacherModel {
  int? id;
  String? name;

  TeacherModel({this.id, this.name});

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class Media {
  int? id;
  String? fileName;

  Media({
    this.id,
    this.fileName,
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
  String? taskId;
  String? url;
  int? id;

  Link({
    this.taskId,
    this.url,
    this.id,
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

