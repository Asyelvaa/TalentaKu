class ClassAnnouncementModel {
  int? id;
  String? userName;
  String? userPhoto;
  int? gradeId;
  int? repliesCount;
  List<Media>? media;

  ClassAnnouncementModel({
    this.id,
    this.userName,
    this.userPhoto,
    this.gradeId,
    this.repliesCount,  
    this.media,
  });

  factory ClassAnnouncementModel.fromJson(Map<String, dynamic> json) {
    var mediaFromJson = json['media'] as List? ?? [];
    List<Media> mediaList = mediaFromJson.map((i) => Media.fromJson(i)).toList();

    return ClassAnnouncementModel(
      id: json['id'],
      userName: json['user']['name'],
      userPhoto: json['user']['photo'],
      gradeId: json['grade']['id'],
      repliesCount: json['replies_count'],
      media: mediaList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userName': userName,
      'userPhoto': userPhoto,
      'gradeId': gradeId,
      'replies_count': repliesCount,
      'media': media?.map((m) => m.toJson()).toList(),
    };
  }
}

class Media {
  int? id;
  String? fileName;
  String? announceId;
  String? createdAt;
  String? updatedAt;

  Media({
    this.id,
    this.fileName,
    this.announceId,
    this.createdAt,
    this.updatedAt,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'],
      fileName: json['file_name'],
      announceId: json['announce_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file_name': fileName,
      'announce_id': announceId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}