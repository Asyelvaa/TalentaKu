import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../domain/models/task_model.dart';
import '../../../../infrastructure/theme/theme.dart';
import '../../../assignment_page/assignment_page.screen.dart';
import '../../controllers/class_detail.controller.dart';

class AssignmentItem extends GetView<ClassDetailController> {
  final String title;
  final String tenggat;
  final String taskId;
  final String gradeId;
  const AssignmentItem({
    super.key,
    required this.title,
    required this.tenggat,
    required this.taskId,
    required this.gradeId
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AssignmentPageScreen(), 
        arguments: {
          'taskId': taskId,
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
                  defaultWidthtSpace,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [                    
                      AutoSizeText(
                        title,
                        style: AppTextStyle.tsSmallBold(AppColor.black),
                        minFontSize: 12,
                        maxLines: null,
                        overflow: TextOverflow.visible,
                      ),
                      Text(tenggat, style: AppTextStyle.tsSmallRegular(AppColor.black),)
                    ],),
                  )                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
