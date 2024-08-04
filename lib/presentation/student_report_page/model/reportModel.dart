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
  final List<dynamic> media;

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
      media: List<dynamic>.from(json['media']),
    );
  }
}
