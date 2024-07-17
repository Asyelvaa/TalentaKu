import 'dart:ffi';

import 'package:flutter_talentaku/domain/models/class_model.dart';
import 'package:flutter_talentaku/infrastructure/dal/services/api_services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ClassDetailController extends GetxController {
  //TODO: Implement ClassActiveController
  final ApiService apiService = ApiService();
  late String gradeId;

  var grade = GradeModel(
    name: '',
    desc: '',
    level: '',
    uniqueCode: '',
    teacherId: 0,
    updatedAt: '',
    createdAt: '',
    id: 0,
    member: [],
    isactive: '',
  ).obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void fetchGradeDetails() async {
    try {
      GradeModel fetchDetailClass = await apiService.getDetailClass(grade.value.id);
      print('Detail class: $fetchDetailClass' );
      
    } catch (e) {
      print('Error fetching grade details: $e');
    }
  }

  void toggleActiveStatus(bool isActive) async {
    await apiService.classStatus(grade.value.id);
    grade.update((val) {
      val!.isactive = isActive ? 'active' : 'inactive';
    });
  }
}
