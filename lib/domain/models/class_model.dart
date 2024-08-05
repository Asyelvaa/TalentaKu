import 'package:flutter_talentaku/domain/models/class_member_model.dart';

class GradeModel {
  String? name;
  String? desc;
  int? levelId;
  String? levelName;
  String? uniqueCode;
  String? teacher;
  String? updatedAt;
  String? createdAt;
  int? id;
  List<ClassMemberModel>? member;
  String? isActiveStatus;

  GradeModel({
    this.name, 
    this.desc,
    this.levelId,
    this.levelName,
    this.uniqueCode,
    this.teacher,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.member,
    this.isActiveStatus,
  });

  factory GradeModel.fromJson(Map<String, dynamic> json) {
    return GradeModel(
      name: json['name'] ?? '',
      desc: json['desc'] ?? '',
      levelId: json['level']['id'] ?? 0,
      levelName: json['level']['name'] ?? '',
      uniqueCode: json['unique_code'] ?? '',
      teacher: json['teacher'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      createdAt: json['created_at'] ?? '',
      id: json['id'] ?? 0,
      member: (json['members'] as List<dynamic>?)
          ?.map((e) => ClassMemberModel.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      isActiveStatus: json['is_active_status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'desc': desc,
      'level': {
        'id': levelId,
        'name': levelName,
      },
      'unique_code': uniqueCode,
      'teacher': teacher,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
      'members': member?.map((e) => e.toJson()).toList(),
      'is_active_status': isActiveStatus,
    };
  }
}
