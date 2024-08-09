class Media {
  final int id;
  final String reportId;
  final String filePath;

  Media({
    required this.id,
    required this.reportId,
    required this.filePath,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'],
      reportId: json['report_id'],
      filePath: json['file_path'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'report_id': reportId,
      'file_path': filePath,
    };
  }
}

class ReportModel {
  final int id;
  final String created;
  final String semesterId;
  final String semesterName;
  final List<String> kegiatanAwal;
  final String awalPoint;
  final List<String> kegiatanInti;
  final String intiPoint;
  final List<String> snack;
  final String snackPoint;
  final List<String> inklusi;
  final String inklusiPoint;
  final List<String> catatan;
  final String studentId;
  final String teacherId;
  final String gradeId;
  final List<Media> media;

  ReportModel({
    required this.id,
    required this.created,
    required this.semesterId,
    required this.semesterName,
    required this.kegiatanAwal,
    required this.awalPoint,
    required this.kegiatanInti,
    required this.intiPoint,
    required this.snack,
    required this.snackPoint,
    required this.inklusi,
    required this.inklusiPoint,
    required this.catatan,
    required this.studentId,
    required this.teacherId,
    required this.gradeId,
    required this.media,
  });

  factory ReportModel.fromJson(Map<String, dynamic> json) {
    return ReportModel(
      id: json['id'],
      created: json['created'],
      semesterId: json['semester_id'],
      semesterName: json['semester_name'],
      kegiatanAwal: List<String>.from(json['kegiatan_awal']),
      awalPoint: json['awal_point'],
      kegiatanInti: List<String>.from(json['kegiatan_inti']),
      intiPoint: json['inti_point'],
      snack: List<String>.from(json['snack']),
      snackPoint: json['snack_point'],
      inklusi: List<String>.from(json['inklusi']),
      inklusiPoint: json['inklusi_point'],
      catatan: List<String>.from(json['catatan']),
      studentId: json['student_id'],
      teacherId: json['teacher_id'],
      gradeId: json['grade_id'],
      media:
          List<Media>.from(json['media'].map((item) => Media.fromJson(item))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created': created,
      'semester_id': semesterId,
      'semester_name': semesterName,
      'kegiatan_awal': kegiatanAwal,
      'awal_point': awalPoint,
      'kegiatan_inti': kegiatanInti,
      'inti_point': intiPoint,
      'snack': snack,
      'snack_point': snackPoint,
      'inklusi': inklusi,
      'inklusi_point': inklusiPoint,
      'catatan': catatan,
      'student_id': studentId,
      'teacher_id': teacherId,
      'grade_id': gradeId,
      'media': media.map((item) => item.toJson()).toList(),
    };
  }
}
