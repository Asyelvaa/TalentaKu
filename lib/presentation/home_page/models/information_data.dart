class Information {
  final String title;
  final List<InformationContent> contents;

  Information({required this.title, required this.contents});

  factory Information.fromJson(Map<String, dynamic> json) {
    var list = json['contents'] as List;
    List<InformationContent> contentList = list.map((i) => InformationContent.fromJson(i)).toList();
    return Information(
      title: json['title'],
      contents: contentList,
    );
  }
}
class InformationContent {
  final String title;
  final List<String> description;

  InformationContent({required this.title, required this.description});

  factory InformationContent.fromJson(Map<String, dynamic> json) {
    return InformationContent(
      title: json['title'],
      description: json['description'],
    );
  }
}


List<Information> informationMockupData = [
  Information(
    title: 'Visi & Misi',
    contents: [
      InformationContent(
        title: 'Visi',
        description: [
          'Pendidikan Untuk semua : Eksploratif, Ekspresif, Mandiri dan Berkarakter',
        ],
      ),
      InformationContent(
        title: 'Misi',
        description: [
          '1. memberikan layanan pendidikan untuk semua anak tanpa membedakan kebutuhannya (abk dan Non ABK), sesuai dengan nilai-nilai moral dan agama',
          '2. Memberikan layanan kegiatan bermain sesuai minat untuk menggali dan mengembangkan potensi anak',
          '3. Membantu semua anak untuk mengembangkan diri dalam memecahkan masalah sehari-hari sesuai tahap perkembangannya',
          '4. Memberikan pengasuhan dan pembelajaran sesuai kondisi, potensi, dan budaya setempat',
        ],
      ),
    ]
  ),
  ];