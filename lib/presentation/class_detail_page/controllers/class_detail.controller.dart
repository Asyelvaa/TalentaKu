import 'package:flutter_talentaku/domain/models/class_model.dart';
import 'package:flutter_talentaku/infrastructure/dal/services/api_services.dart';
import 'package:get/get.dart';

class ClassDetailController extends GetxController {
  //TODO: Implement ClassActiveController
  final ApiService apiService = ApiService();

  final count = 0.obs;
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

  void increment() => count.value++;

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

  void fetchGradeDetails() async {
    try {
      var fetchedGrade = await apiService.getGrades();
      grade.value = fetchedGrade.first; 
    } catch (e) {
      print('Error fetching grade details: $e');
    }
  }
}
