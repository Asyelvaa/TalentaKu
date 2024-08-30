import 'package:get/get.dart';

import '../../../../presentation/submission_page_student/controllers/submission_page_student.controller.dart';

class SubmissionPageStudentControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubmissionPageStudentController>(
      () => SubmissionPageStudentController(),
    );
  }
}
