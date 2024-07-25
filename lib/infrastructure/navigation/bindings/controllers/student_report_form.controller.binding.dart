import 'package:get/get.dart';

import '../../../../presentation/student_report_form/controllers/student_report_form.controller.dart';

class StudentReportFormControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StudentReportFormController>(
      () => StudentReportFormController(),
    );
  }
}
