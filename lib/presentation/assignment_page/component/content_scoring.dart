import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/assignment_page/component/submission_item.dart';
import 'package:get/get.dart';

import '../controllers/assignment_page.controller.dart';

class ContentScoring extends StatelessWidget {
  final String taskId;

  ContentScoring({required this.taskId});

  @override
  Widget build(BuildContext context) {
    final AssignmentPageController controller = Get.find<AssignmentPageController>();

    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (controller.submissionsWithNullScore.isEmpty) {
        return Center(child: Text('Belum ada siswa yang mengumpulkan tugas'));
      }

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spaceHeightSmall,
            Text('Diserahkan', style: AppTextStyle.tsBodyBold(AppColor.black)),
            spaceHeightExtraSmall,
            if (controller.submissionsWithNullScore.isEmpty)
              Text('No submissions with null score', style: AppTextStyle.tsSmallRegular(AppColor.black)),
            ...controller.submissionsWithNullScore.map((submission) => SubmissionItem(
                  studentName: submission.studentSubmitted?.name ?? 'Unknown',
                  score: null,
                  submittedAt: submission.submittedAt!,
                )),
            spaceHeightNormal,
            Text('Dinilai', style: AppTextStyle.tsBodyBold(AppColor.black)),
            spaceHeightExtraSmall,
            if (controller.submissionsWithScore.isEmpty)
              Text('Belum ada tugas yang dinilai', style: AppTextStyle.tsSmallRegular(AppColor.black)),
            ...controller.submissionsWithScore.map((submission) => SubmissionItem(
                  studentName: submission.studentSubmitted?.name ?? 'Unknown',
                  score: submission.score, // Display score if available
                  submittedAt: submission.submittedAt!,
                )),
          ],
        ),
      );
    });
  }
}
