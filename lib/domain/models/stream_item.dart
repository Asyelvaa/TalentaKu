// import 'package:flutter_talentaku/domain/models/album_model.dart';
// import 'package:flutter_talentaku/domain/models/class_model.dart';
// import 'package:flutter_talentaku/domain/models/user_model.dart';

// class StreamItem {
//   late String type;
//   StreamTaskModel? task;
//   StreamAnnouncementModel? announcement;

//   StreamItem({this.task, this.announcement}) {
//     type = task?.type ?? announcement?.type ?? '';
//   }

//   factory StreamItem.fromJson(Map<String, dynamic> json) {
//     if (json['type'] == 'task') {
//       return StreamItem(task: StreamTaskModel.fromJson(json));
//     } else if (json['type'] == 'announcement') {
//       return StreamItem(announcement: StreamAnnouncementModel.fromJson(json));
//     } else {
//       throw Exception('Unknown content type');
//     }
//   }
// }

// class StreamTaskModel {
//   int? id;
//   String? type;
//   String? preview;
//   GradeModel? grade;
//   DateTime? createdAt;
//   DateTime? updatedAt;

//   StreamTaskModel({
//     this.id,
//     this.type,
//     this.preview,
//     this.grade,
//     this.createdAt,
//     this.updatedAt,
//   });

//   factory StreamTaskModel.fromJson(Map<String, dynamic> json) {
//     return StreamTaskModel(
//       id: json['id'],
//       type: json['type'],
//       preview: json['preview'],
//       grade: json['grade'] != null ? GradeModel.fromJson(json['grade']) : null,
//       createdAt: json['created_at'] != null
//           ? DateTime.parse(json['created_at'])
//           : null,
//       updatedAt: json['updated_at'] != null
//           ? DateTime.parse(json['updated_at'])
//           : null,
//     );
//   }
// }

// class StreamAnnouncementModel {
//   int? id;
//   String? type;
//   UserModel? user;
//   GradeModel? grade;
//   List<String>? announcements;
//   List<Media>? media;
//   List<Reply>? replies;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   List<String>? preview;

//   StreamAnnouncementModel({
//     this.id,
//     this.type,
//     this.user,
//     this.grade,
//     this.announcements,
//     this.media,
//     this.replies,
//     this.createdAt,
//     this.updatedAt,
//     this.preview,
//   });

//   factory StreamAnnouncementModel.fromJson(Map<String, dynamic> json) {
//     return StreamAnnouncementModel(
//       id: json['id'],
//       type: json['type'],
//       user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
//       grade: json['grade'] != null ? GradeModel.fromJson(json['grade']) : null,
//       announcements: json['announcements'] != null
//           ? List<String>.from(json['announcements'])
//           : null,
//       media: json['media'] != null
//           ? (json['media'] as List).map((i) => Media.fromJson(i)).toList()
//           : null,
//       replies: json['replies'] != null
//           ? (json['replies'] as List).map((i) => Reply.fromJson(i)).toList()
//           : null,
//       createdAt: json['created_at'] != null
//           ? DateTime.parse(json['created_at'])
//           : null,
//       updatedAt: json['updated_at'] != null
//           ? DateTime.parse(json['updated_at'])
//           : null,
//       preview: json['preview'] != null
//           ? List<String>.from(json['preview'])
//           : null,
//     );
//   }
// }


