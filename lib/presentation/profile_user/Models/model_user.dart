class Grade {
  final int id;
  final String name;
  final String desc;
  final String uniqueCode;
  final int isActive;
  final String isActiveStatus;
  final Teacher teacher;
  final Level level;
  final List<Member> members;

  Grade({
    required this.id,
    required this.name,
    required this.desc,
    required this.uniqueCode,
    required this.isActive,
    required this.isActiveStatus,
    required this.teacher,
    required this.level,
    required this.members,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      id: json['id'],
      name: json['name'],
      desc: json['desc'],
      uniqueCode: json['unique_code'],
      isActive: json['is_active'],
      isActiveStatus: json['is_active_status'],
      teacher: Teacher.fromJson(json['teacher']),
      level: Level.fromJson(json['level']),
      members: (json['members'] as List).map((i) => Member.fromJson(i)).toList(),
    );
  }
}

class Teacher {
  final int id;
  final String name;
  final String email;
  final String identificationNumber;
  final String address;
  final String photo;
  final String birthInformation;
  final List<String> roles;
  final List<String> grades;

  Teacher({
    required this.id,
    required this.name,
    required this.email,
    required this.identificationNumber,
    required this.address,
    required this.photo,
    required this.birthInformation,
    required this.roles,
    required this.grades,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      identificationNumber: json['identification_number'],
      address: json['address'],
      photo: json['photo'],
      birthInformation: json['birth_information'],
      roles: List<String>.from(json['roles']),
      grades: List<String>.from(json['grades']),
    );
  }
}

class Level {
  final int id;
  final String name;

  Level({
    required this.id,
    required this.name,
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    return Level(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Member {
  final int id;
  final String name;
  final String email;
  final String identificationNumber;
  final String address;
  final String? photo;
  final String birthInformation;
  final List<String> roles;
  final List<String> grades;

  Member({
    required this.id,
    required this.name,
    required this.email,
    required this.identificationNumber,
    required this.address,
    this.photo,
    required this.birthInformation,
    required this.roles,
    required this.grades,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      identificationNumber: json['identification_number'],
      address: json['address'],
      photo: json['photo'],
      birthInformation: json['birth_information'],
      roles: List<String>.from(json['roles']),
      grades: List<String>.from(json['grades']),
    );
  }
}
