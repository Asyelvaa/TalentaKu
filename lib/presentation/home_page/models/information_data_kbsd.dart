class Information {
  final String informationTitle;
  final List<InformationData> informationData;

  Information({required this.informationTitle, required this.informationData});

  factory Information.fromJson(Map<String, dynamic> json) {
    return Information(
      informationTitle: json['information_title'],
      informationData: (json['information_data'] as List)
          .map((data) => InformationData.fromJson(data))
          .toList(),
    );
  }
}

class InformationData {
  final String title;
  final List<String> desc;

  InformationData({required this.title, required this.desc});

  factory InformationData.fromJson(Map<String, dynamic> json) {
    return InformationData(
      title: json['title'],
      desc: List<String>.from(json['desc']),
    );
  }
}
