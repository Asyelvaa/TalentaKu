class ClassAnnouncementModel {
  int? id;
  String? userName;
  String? userPhoto;
  int? gradeId;
  List<String>? comments;
  List<Media>? media;

  ClassAnnouncementModel({
    this.id,
    this.userName,
    this.userPhoto,
    this.gradeId,
    this.comments,  
    this.media,
  });

  factory ClassAnnouncementModel.fromJson(Map<String, dynamic> json) {
    var commentsFromJson = json['comments'] ?? [];
    List<String> commentList = List<String>.from(commentsFromJson);

    var mediaFromJson = json['media'] as List? ?? [];
    List<Media> mediaList = mediaFromJson.map((i) => Media.fromJson(i)).toList();

    return ClassAnnouncementModel(
      id: json['id'],
      userName: json['user']['name'],
      userPhoto: json['user']['photo'],
      gradeId: json['grade']['id'],
      comments: commentList,
      media: mediaList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'userPhoto': userPhoto,
      'gradeId': gradeId,
      'comments': comments,
      'media': media?.map((m) => m.toJson()).toList(),
    };
  }
}

class Media {
  int? id;
  String? fileName;
  String? originalName;
  String? filePath;
  int? fileSize;
  String? fileType;

  Media({
    this.id,
    this.fileName,
    this.originalName,
    this.filePath,
    this.fileSize,
    this.fileType,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'],
      fileName: json['file_name'],
      originalName: json['original_name'],
      filePath: json['file_path'],
      fileSize: json['file_size'],
      fileType: json['file_type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file_name': fileName,
      'original_name': originalName,
      'file_path': filePath,
      'file_size': fileSize,
      'file_type': fileType,
    };
  }
}