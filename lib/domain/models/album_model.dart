class Album {
 int? id;
 List<String>? desc;
 String? date;
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
      date: json['date'],
      gradeId: json['grade_id'],
      teacherId: json['teacher_id'],
      media: mediaList,
    );
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
}
