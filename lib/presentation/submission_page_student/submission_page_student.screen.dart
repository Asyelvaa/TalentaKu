import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../infrastructure/theme/theme.dart';
import '../common_widget/back_appbar.dart';
import 'controllers/submission_page_student.controller.dart';

class SubmissionPageStudentScreen extends StatelessWidget {
  const SubmissionPageStudentScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubmissionPageStudentController());
     return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: BackAppbar(titleAppbar: 'Tugas Selesai')),
      body: Obx(() {
        final task = controller.taskData.value;
        final submission = controller.submissionData.value!;
        if (controller.isLoadingTask.value || controller.isLoadingSubmission.value) {
          return Center(child: CircularProgressIndicator());
        } else if (submission == null || task == null) {
          return Center(
            child: Text('Error loading data'),
          );
        }
        else return SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [                  
                  Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColor.blue200, borderRadius: defaultBorderRadius),
                      child: Text(
                        'Nilai : ${submission.score!}',
                        style: AppTextStyle.tsBodyBold(AppColor.black),
                      ))
                ],
              ),
              spaceHeightSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: defaultBorderRadius),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 24,
                            color: AppColor.red,
                          ),
                          defaultWidthtSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Tenggat Tugas',
                                  style:
                                      AppTextStyle.tsSmallBold(AppColor.black)),
                              Text(
                                DateFormat('EEE, d/M/yyyy').format(
                                        controller.taskData.value!.endDate!) ??
                                    '',
                                style:
                                    AppTextStyle.tsSmallRegular(AppColor.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppColor.white,
                          borderRadius: defaultBorderRadius),
                      child: Row(
                        children: [
                          Icon(
                            Icons.calendar_month,
                            size: 24,
                            color: AppColor.blue600,
                          ),
                          defaultWidthtSpace,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Dikumpulkan',
                                  style:
                                      AppTextStyle.tsSmallBold(AppColor.black)),
                              Text(
                                DateFormat('EEE, d/M/yyyy').format(
                                        controller.submissionData.value!.submittedAt!) ??
                                    '',
                                style:
                                    AppTextStyle.tsSmallRegular(AppColor.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              spaceHeightSmall,
              Container(
                width: widthScreen,
                decoration: BoxDecoration(
                    color: AppColor.blue50, borderRadius: defaultBorderRadius),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${controller.taskData.value!.title!}',
                        style: AppTextStyle.tsBodyBold(AppColor.black),
                      ),
                      Divider(
                        color: AppColor.blue600,
                      ),
                      Text(
                        '${controller.taskData.value!.desc?.toList().join('\n') ?? ''}',
                        style: AppTextStyle.tsBodyRegular(AppColor.black),
                      ),
                    ],
                  ),
                ),
              ),
              spaceHeightNormal,
              Row(
                children: [
                  Icon(Icons.task_alt, size: 20, color: AppColor.blue600),
                  defaultWidthtSpace,
                  Text(
                    'Hasil Pengerjaan',
                    style: AppTextStyle.tsBodyBold(AppColor.black),
                  ),
                ],
              ),
              spaceHeightSmall,
              Container(
                height: heightScreen * 0.3,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: submission.submissionMedia!.length ?? 0,
                  itemBuilder: (context, index) {
                    final media = submission.submissionMedia![index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.network(
                        '${media.fileName!}' ?? 'unknown',
                        fit: BoxFit.scaleDown,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
