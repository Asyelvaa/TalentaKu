import 'package:flutter_talentaku/domain/models/task_model.dart';
import 'package:flutter_talentaku/domain/models/user_model.dart';
import 'submission_media.dart';

class SubmissionDetailModel {
  int? submissionId;
  String? taskId;
  StudentSubmitted? studentSubmitted;
  List<SubmissionMedia>? submissionMedia;
  DateTime? submittedAt;
  bool? isLate;
  String? status;
  String? score;

  SubmissionDetailModel({
    this.submissionId,
    this.taskId,
    this.studentSubmitted,
    this.submissionMedia,
    this.submittedAt,
    this.isLate,
    this.status,
    this.score,
  });

  factory SubmissionDetailModel.fromJson(Map<String, dynamic> json) {
    final studentSubmittedJson = json['student_submitted'];
    if (studentSubmittedJson == null) {
      throw Exception('student_submitted is null');
    }

    return SubmissionDetailModel(
      submissionId: json['id'],
      taskId: json['task_id']?.toString(),
      studentSubmitted: StudentSubmitted.fromJson(studentSubmittedJson),
      submissionMedia: (json['submmision_media'] as List<dynamic>?)
          ?.map((media) => SubmissionMedia.fromJson(media as Map<String, dynamic>))
          .toList(),  
      submittedAt:  DateTime.parse(json['submitted_at']),
      isLate: json['is_late'],
      status: json['status'],
      score: json['score']?.toString() ?? 'Belum dinilai',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': submissionId,
      'task_id': taskId,
      'student_submitted': studentSubmitted?.toJson(),
      'submission_media': submissionMedia?.map((media) => media.toJson()).toList(),
      'submitted_at': submittedAt?.toIso8601String(),
      'is_late': isLate,
      'status': status,
      'score': score ?? 'Belum dinilai',
    };
  }
}

class StudentSubmitted {
  final int id;
  final String name;

  StudentSubmitted({
    required this.id,
    required this.name,
  });

  factory StudentSubmitted.fromJson(Map<String, dynamic> json) {
    return StudentSubmitted(
      id: json['id'] ?? 0, 
      name: json['name'] ?? '', 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
