import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/screens.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../controllers/class_detail.controller.dart';

class SubmissionItem extends GetView<ClassDetailController> {
  final String title;
  final String tenggat;
  final String taskId;
  final String gradeId;
  final String completionsId;
  const SubmissionItem({
    super.key,
    required this.title,
    required this.tenggat,
    required this.taskId,
    required this.gradeId,
    required this.completionsId
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => SubmissionCompletePageScreem(), arguments: {
          'taskId': taskId,
          'gradeId' : gradeId,
          'completionsId': completionsId
          // controller.submissionsWithScore[index].submissionId.toString(),
          // 'studentIdSubmitted' : GetStorage().read('dataUser')?['id'].toString()
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
            ]),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  CircleAvatar(
                    child: Icon(
                      Icons.assignment,
                      color: AppColor.black,
                      size: 20,
                    ),
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
