import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/submission_page_student.controller.dart';

class SubmissionPageStudentScreen extends StatelessWidget {
  const SubmissionPageStudentScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubmissionPageStudentController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail submission'),
        centerTitle: true,
      ),
      body:  Center(
        child: Column(
          children: [
            Text('${controller.submissionData.value.id}'),
          ],
        )
      ),
    );
  }
}
