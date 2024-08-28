// // import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_talentaku/presentation/common_widget/custom_button.dart';

// import 'package:get/get.dart';

// import '../../infrastructure/theme/theme.dart';
// import '../common_widget/back_appbar.dart';
// import '../common_widget/text_background.dart';
// import 'controllers/submission_page.controller.dart';

// class SubmissionCompletePageScreem extends GetView<SubmissionPageController> {
//   const SubmissionCompletePageScreem({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(kToolbarHeight),
//           child: BackAppbar(titleAppbar: 'Pengumpulan Tugas'),
//         ),
        
//     );
//   }
// }
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/submission_page/controllers/submission_page.controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../infrastructure/theme/theme.dart';
import '../common_widget/back_appbar.dart';
import '../common_widget/text_background.dart';

class SubmissionCompletePageScreem extends StatelessWidget {
  // final completionsId;
  const SubmissionCompletePageScreem({
    super.key, 
    // required this.completionsId
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubmissionPageController());
    // var submission = controller.submission.value;
    // var task = controller.task;

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: BackAppbar(titleAppbar: 'Tugas Selesai')),
      body: Obx(() {
        final submission = controller.submissionComplete;
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        // return Text('${controller.submissionComplete['student_submitted']?['name'] ?? 'Unknown'}');
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.person, size: 20, color: AppColor.black),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        '${submission['student_submitted']?['name'] ?? 'Unknown'}',
                        style: AppTextStyle.tsSmallBold(AppColor.black),
                      ),
                    ],
                  ),                  
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: AppColor.blue200,
                        shape: BoxShape.circle
                        ),
                    child: Text('${submission['score']}', style: AppTextStyle.tsBodyBold(AppColor.black),)
                  )
                ],
              ),
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
                                  style: AppTextStyle.tsSmallBold(AppColor.black)),
                              Text(
                                DateFormat('EEE, d/M/yyyy')
                                        .format(controller.task.value.endDate!) ??
                                    '',
                                style: AppTextStyle.tsSmallRegular(AppColor.black),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width:4),
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
                                  style: AppTextStyle.tsSmallBold(AppColor.black)),
                              Text(
                                DateFormat('EEE, d/M/yyyy').format(DateTime.parse(submission['submitted_at'])) ??
                                    '',
                                style: AppTextStyle.tsSmallRegular(AppColor.black),
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
                        '${controller.task.value.title}',
                        style: AppTextStyle.tsBodyBold(AppColor.black),
                      ),
                      Divider(
                        color: AppColor.blue600,
                      ),
                      Text(
                        '${controller.task.value.desc!.join(', ')}',
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
                height: 100,
                child:  ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: submission['submmision_media']?.length ?? 0,
                  itemBuilder: (context, index) {
                    final media = submission['submmision_media'][index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Image.network(
                        'https://talentaku.site/image/${media['fileName']}' ?? 'unknown',
                        fit: BoxFit.cover,
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
