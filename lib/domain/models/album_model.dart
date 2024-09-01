class Album {
 int? id;
 List<String>? desc;
 DateTime? date;
 String? gradeId;
 String? teacherId;
 List<Media>? media;

  Album({
   this.id, 
   this.desc, 
   this.date, 
   this.gradeId,
   this.teacherId,
   this.media
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    var mediaList = (json['media'] as List)
        .map((mediaJson) => Media.fromJson(mediaJson))
        .toList();

    return Album(
      id: json['id'],
      desc: List<String>.from(json['desc'] ?? []),
      date: json['date'] != null ? DateTime.tryParse(json['date']) : null,
      gradeId: json['grade_id'],
      teacherId: json['teacher_id'],
      media: mediaList,
    );
  }

 Map<String, dynamic> toJson() {
    return {
      'id': id,
      'desc': desc,
      'date': date?.toIso8601String(),
      'grade_id': gradeId,
      'teacher_id': teacherId,
      'media': media?.map((x) => x.toJson()).toList(),
    };
  }

}

class Media {
 int? id;
 String? filePath;

  Media({
   this.id, 
   this.filePath,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    const String baseUrl = 'https://talentaku.site/image/album-media/';
    return Media(
      id: json['id'],
      filePath: baseUrl + json['file_name'],
    );
  }

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file_name': filePath?.replaceFirst('https://talentaku.site/image/album-media/', ''),
    };
  }
}
