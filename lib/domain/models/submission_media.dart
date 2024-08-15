  class SubmissionMedia {
    int? id;
    String? submission_id;
    String? fileName;

    SubmissionMedia({this.id, this.submission_id, this.fileName});

    factory SubmissionMedia.fromJson(Map<String, dynamic> json) {
      final baseUrl =  'https://talentaku.site/image/task-submission/';
      return SubmissionMedia(
        id: json['id'],
        submission_id: json['submission_id'],
        fileName: baseUrl + json['file_name'],
      );
    }

    Map<String, dynamic> toJson() {
      return {
        'id': id,
        'submission_id': submission_id,
        'file_name': fileName,
      };
    }
  }