import 'dart:convert';

// ReportModel to match the structure of a single report
class ReportModel {
  final int id;
  final String created;
  final String semesterId;
  final String kegiatanAwal;
  final String awalPoint;
  final String kegiatanInti;
  final String intiPoint;
  final String snack;
  final String snackPoint;
  final String inklusi;
  final String inklusiPoint;
  final String catatan;
  final String teacherId;
  final String studentId;
  final String gradeId;
  final String createdAt;
  final String updatedAt;
  final List<MediaModel> media;

  ReportModel({
    required this.id,
    required this.created,
    required this.semesterId,
    required this.kegiatanAwal,
    required this.awalPoint,
    required this.kegiatanInti,
    required this.intiPoint,
    required this.snack,
    required this.snackPoint,
    required this.inklusi,
    required this.inklusiPoint,
    required this.catatan,
    required this.teacherId,
    required this.studentId,
    required this.gradeId,
    required this.createdAt,
    required this.updatedAt,
    required this.media,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'],
      created: json['created'],
      semesterId: json['semester_id'],
      kegiatanAwal: json['kegiatan_awal'],
      awalPoint: json['awal_point'],
      kegiatanInti: json['kegiatan_inti'],
      intiPoint: json['inti_point'],
      snack: json['snack'],
      snackPoint: json['snack_point'],
      inklusi: json['inklusi'],
      inklusiPoint: json['inklusi_point'],
      catatan: json['catatan'],
      teacherId: json['teacher_id'],
      studentId: json['student_id'],
      gradeId: json['grade_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      media: (json['media'] as List).map((i) => MediaModel.fromJson(i)).toList(),
    );
  }
}

// MediaModel to match the media objects in the report
class MediaModel {
  final int id;
  final String studentReportId;
  final String filePath;
  final String createdAt;
  final String updatedAt;

  MediaModel({
    required this.id,
    required this.studentReportId,
    required this.filePath,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MediaModel.fromJson(Map<String, dynamic> json) {
    return MediaModel(
      id: json['id'],
      studentReportId: json['student_report_id'],
      filePath: json['file_path'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
