import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/submission_page/submission_scoring_page.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SubmissionItem extends StatelessWidget {
  final String studentName;
  final String? score;
  final DateTime submittedAt;

  const SubmissionItem({
    Key? key,
    required this.studentName,
    this.score,
    required this.submittedAt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedDate = submittedAt != null ? DateFormat.yMMMd().format(submittedAt) : 'Unknown';

    return GestureDetector(
      // onTap: () { Get.to(() {});},
      onTap: () { Get.to(() => SubmissionScoringPage(), arguments: {
        'taskId': Get.arguments['taskId'],
        'gradeId': Get.arguments['gradeId'],
        'studentSubmitted': studentName,
      });},
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColor.grey)),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              child: Image.asset("assets/images/student.png"),
              radius: 20,
              backgroundColor: AppColor.blue100,
            ),
            defaultWidthtSpace,
           Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(studentName,
                  style: AppTextStyle.tsSmallBold(AppColor.black),
                  ),
                  Text(
                    formattedDate,
                    style: AppTextStyle.tsSmallRegular(AppColor.blue600),
                  ),
                ],
              ),
            ),
            if (score != null)
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColor.blue600,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  score!,
                  style: AppTextStyle.tsLittle.copyWith(
                    color: AppColor.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
