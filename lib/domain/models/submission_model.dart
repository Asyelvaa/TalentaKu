import 'package:flutter_talentaku/domain/models/user_model.dart';

import 'submission_media.dart';
import 'task_model.dart';

class SubmissionModel {
  final int? id;
  final int? taskId;
  final int? studentId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserModel? user;
  final Task? task;
  final List<SubmissionMedia>? media;

  SubmissionModel({
    this.id,
    this.taskId,
    this.studentId,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.task,
    this.media,
  });

  factory SubmissionModel.fromJson(Map<String, dynamic> json) {
    return SubmissionModel(
      id: json['id'],
      taskId: json['task_id'],
      studentId: json['student_id'],
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      task: json['task'] != null ? Task.fromJson(json['task']) : null,
      media: json['media'] != null
          ? (json['media'] as List)
              .map((mediaItem) => SubmissionMedia.fromJson(mediaItem))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task_id': taskId,
      'student_id': studentId,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'user': user?.toJson(),
      'task': task?.toJson(),
      'media': media?.map((mediaItem) => mediaItem.toJson()).toList(),
    };
  }
}