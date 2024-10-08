import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/class_detail.controller.dart';
import 'assignment_list_student.dart';
import 'assignment_list_teacher.dart';

class ContentAssignment extends GetView<ClassDetailController> {
  const ContentAssignment({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      // child: Text('test'),
      child: Obx(() {
         if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else if (controller.userRole.any((role) => role.contains('Murid') )) {
          return AssignmentListStudent();
        } else if(controller.userRole.any((role) => role.contains('Guru'))) {
          return AssignmentListTeacher();
        } else {
          return Text(controller.userRole.toString());
        }
      }),
    );
  }
}
