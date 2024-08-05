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

      if (controller.submissionsWithNullScore.isEmpty && controller.submissionsWithScore.isEmpty) {
        return Center(child: Text('Belum ada siswa yang mengumpulkan tugas'));
      }

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            spaceHeightSmall,
            Text('Diserahkan', style: AppTextStyle.tsBodyBold(AppColor.black)),
            spaceHeightExtraSmall,
            Obx(() {
              if (controller.submissionsWithNullScore.isEmpty) {
                return Text('Belum ada tugas yang diserahkan', style: AppTextStyle.tsSmallRegular(AppColor.black));
              } else
              return Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.submissionsWithNullScore.length,
                  itemBuilder: (context, index) {
                    final submission = controller.submissionsWithNullScore[index];
                    return SubmissionItem(
                      studentName: submission.studentSubmitted?.name ?? 'Unknown',
                      score: null,
                      submittedAt: submission.submittedAt!,
                    );
                  },
                ),
              );
            }),
            spaceHeightNormal,
            Text('Dinilai', style: AppTextStyle.tsBodyBold(AppColor.black)),
            spaceHeightExtraSmall,
            Obx(() {
              if (controller.submissionsWithScore.isEmpty) {
                return Text('Belum ada tugas yang dinilai', style: AppTextStyle.tsSmallRegular(AppColor.black));
              } else
              return Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.submissionsWithScore.length,
                  itemBuilder: (context, index) {
                    final submission = controller.submissionsWithScore[index];
                    return SubmissionItem(
                      studentName: submission.studentSubmitted?.name ?? 'Unknown',
                      score: submission.score,
                      submittedAt: submission.submittedAt!,
                    );
                  },
                ),
              );
            }),
          ],
        ),
      );
    });
  }
}
