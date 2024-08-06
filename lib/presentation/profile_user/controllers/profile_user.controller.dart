import 'package:flutter_talentaku/domain/models/class_member_model.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';

class ProfileUserController extends GetxController {
  Rx<ClassMemberModel> student = ClassMemberModel().obs;
  var isLoading = false.obs;
  final roles = <String>[].obs;
  final grades = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    student.value = Get.arguments['student'] as ClassMemberModel;
   
  }

}
