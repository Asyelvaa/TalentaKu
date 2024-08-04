import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/models/task_model.dart';
import '../../../../infrastructure/theme/theme.dart';
import '../../../assignment_page/assignment_page.screen.dart';
import '../../controllers/class_detail.controller.dart';

class MateriItem extends GetView<ClassDetailController> {
  final String title;
  final String tenggat;
  final Task task;
  final String gradeId;
  const MateriItem({
    super.key,
    required this.title,
    required this.tenggat,
    required this.task,
    required this.gradeId
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AssignmentPageScreen(), 
        arguments: {
          'task': task,
          'gradeId' : gradeId
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 12),
        width: widthScreen,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), 
            color: AppColor.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2), 
                blurRadius: 2, 
                offset: Offset(0, 1), 
              )
            ]
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  CircleAvatar(
                    child: Icon(Icons.assignment, color: AppColor.black,size: 20  ,),
                    backgroundColor: AppColor.blue100,
                    radius: 16,
                  ),
                  SizedBox(width: 8,),
                  Text(title,
                      style: AppTextStyle.tsLittle
                  ),
                  SizedBox(width: 8,),
                  Text(tenggat, style: AppTextStyle.tsLittle,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
