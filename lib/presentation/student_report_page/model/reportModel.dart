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
  final List<String> kegiatanAwalDihalaman;
  final String dihalamanHasil;
  final List<String> kegiatanAwalBerdoa;
  final String berdoaHasil;
  final List<String> kegiatanIntiSatu;
  final String intiSatuHasil;
  final List<String> kegiatanIntiDua;
  final String intiDuaHasil;
  final List<String> kegiatanIntiTiga;
  final String intiTigaHasil;
  final List<String> snack;
  final List<String> inklusi;
  final String inklusiHasil;
  final String inklusiPenutup;
  final String inklusiPenutupHasil;
  final String inklusiDoa;
  final String inklusiDoaHasil;
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
    required this.kegiatanAwalDihalaman,
    required this.dihalamanHasil,
    required this.kegiatanAwalBerdoa,
    required this.berdoaHasil,
    required this.kegiatanIntiSatu,
    required this.intiSatuHasil,
    required this.kegiatanIntiDua,
    required this.intiDuaHasil,
    required this.kegiatanIntiTiga,
    required this.intiTigaHasil,
    required this.snack,
    required this.inklusi,
    required this.inklusiHasil,
    required this.inklusiPenutup,
    required this.inklusiPenutupHasil,
    required this.inklusiDoa,
    required this.inklusiDoaHasil,
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
      kegiatanAwalDihalaman: List<String>.from(json['kegiatan_awal_dihalaman']),
      dihalamanHasil: json['dihalaman_hasil'],
      kegiatanAwalBerdoa: List<String>.from(json['kegiatan_awal_berdoa']),
      berdoaHasil: json['berdoa_hasil'],
      kegiatanIntiSatu: List<String>.from(json['kegiatan_inti_satu']),
      intiSatuHasil: json['inti_satu_hasil'],
      kegiatanIntiDua: List<String>.from(json['kegiatan_inti_dua']),
      intiDuaHasil: json['inti_dua_hasil'],
      kegiatanIntiTiga: List<String>.from(json['kegiatan_inti_tiga']),
      intiTigaHasil: json['inti_tiga_hasil'],
      snack: List<String>.from(json['snack']),
      inklusi: List<String>.from(json['inklusi']),
      inklusiHasil: json['inklusi_hasil'],
      inklusiPenutup: json['inklusi_penutup'],
      inklusiPenutupHasil: json['inklusi_penutup_hasil'],
      inklusiDoa: json['inklusi_doa'],
      inklusiDoaHasil: json['inklusi_doa_hasil'],
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
      'kegiatan_awal_dihalaman': kegiatanAwalDihalaman,
      'dihalaman_hasil': dihalamanHasil,
      'kegiatan_awal_berdoa': kegiatanAwalBerdoa,
      'berdoa_hasil': berdoaHasil,
      'kegiatan_inti_satu': kegiatanIntiSatu,
      'inti_satu_hasil': intiSatuHasil,
      'kegiatan_inti_dua': kegiatanIntiDua,
      'inti_dua_hasil': intiDuaHasil,
      'kegiatan_inti_tiga': kegiatanIntiTiga,
      'inti_tiga_hasil': intiTigaHasil,
      'snack': snack,
      'inklusi': inklusi,
      'inklusi_hasil': inklusiHasil,
      'inklusi_penutup': inklusiPenutup,
      'inklusi_penutup_hasil': inklusiPenutupHasil,
      'inklusi_doa': inklusiDoa,
      'inklusi_doa_hasil': inklusiDoaHasil,
      'catatan': catatan,
      'student_id': studentId,
      'teacher_id': teacherId,
      'grade_id': gradeId,
      'media': media.map((item) => item.toJson()).toList(),
    };
  }
}
