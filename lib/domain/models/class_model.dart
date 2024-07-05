import 'package:flutter_talentaku/domain/models/member_class_model.dart';

class GradeModel {
  final String name;
  final String desc;
  final String level;
  final String uniqueCode;
  final int teacherId;
  final String updatedAt;
  final String createdAt;
  final int id;
  final List<MemberClassModel> member;
  String isactive;

  GradeModel({
    required this.name,
    required this.desc,
    required this.level,
    required this.uniqueCode,
    required this.teacherId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
    required this.member,
    required this.isactive,
  });

  factory GradeModel.fromJson(Map<String, dynamic> json) {
    return GradeModel(
      name: json['name'] ?? '',
      desc: json['desc'] ?? '',
      level: json['level'] ?? '',
      uniqueCode: json['unique_code'] ?? '',
      teacherId: json['teacher_id'] ?? 0,
      updatedAt: json['updated_at'] ?? '',
      createdAt: json['created_at'] ?? '',
      id: json['id'] ?? 0,
      member: (json['members'] as List<dynamic>?)
          ?.map((e) => MemberClassModel.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      isactive: json['isactive'] ?? '',
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'desc': desc,
      'level': level,
      'unique_code': uniqueCode,
      'teacher_id': teacherId,
      'updated_at': updatedAt,
      'created_at': createdAt,
      'id': id,
      'members': member.map((e) => e.toJson()).toList(),
      'isactive': isactive,

    };
  }
}
