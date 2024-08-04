import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/submission_page/controllers/submission_page.controller.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';
import '../common_widget/back_appbar.dart';
import '../common_widget/text_background.dart';

class SubmissionScoringPage extends StatelessWidget {
  const SubmissionScoringPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubmissionPageController());
    var submission = controller.submission.value;
    var task = controller.task;
    
    return Scaffold(
      appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: BackAppbar(titleAppbar: 'Penilaian Tugas')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Task Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('Title: ${controller.task.value.title}'),
              Text('Start Date: ${controller.task.value.startDate}'),
              Text('End Date: ${controller.task.value.endDate}'),
              SizedBox(height: 20),
              Text(
                'Submissions',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
               Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Student: ${controller.submission.value.studentSubmitted?.name ?? 'Unknown'}',
                style: AppTextStyle.tsBodyBold(AppColor.black),
              ),
              SizedBox(height: 10),
              Text(
                'Submitted At: ${controller.submission.value.submittedAt}',
                style: AppTextStyle.tsBodyRegular(AppColor.black),
              ),
              SizedBox(height: 10),
              Text(
                'Submission Media:',
                style: AppTextStyle.tsBodyBold(AppColor.black),
              ),
              Container(
                height: 100,
                child: Image.network(
                  'https://talentaku.site/image/task-submission/${controller.submission.value.submissionMedia?[0].fileName}' ?? 'unknown',
                  fit: BoxFit.scaleDown,
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: controller.submission.value.submissionMedia?.length ?? 0,
                itemBuilder: (context, index) {
                  final media = controller.submission.value.submissionMedia?[index];
                  return ListTile(
                    title: Text(media?.fileName ?? 'Unknown File'),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                'Score the Submission:',
                style: AppTextStyle.tsBodyBold(AppColor.black),
              ),
              Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: ['A', 'B', 'C'].map((score) {
                        return ElevatedButton(
                          onPressed: () {
                            controller.scoreController.text = score;
                            controller.selectedScore.value = score;
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: controller.selectedScore.value == score ? Colors.green : null,
                          ),
                          child: Text(score),
                        );
                      }).toList(),
                    );
                  }),
              ElevatedButton(
                    onPressed: () async {
                      await controller.scoringSubmission();
                    }, 
                    child: Center(
                      child: Text(
                        'Kirim Nilai',
                        style: AppTextStyle.tsNormal,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromHeight(50),
                      backgroundColor: AppColor.blue100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
            ],
          ),
            ],
          ),
        );
      }),
    );

    // return SingleChildScrollView(
    //   child: Padding(
    //       padding: EdgeInsets.symmetric(vertical: heightScreen * 0.02, horizontal: widthScreen * 0.05),
    //       child: Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           TextWithBackground(
    //               colorBackground: AppColor.grey,
    //               text: 'Tengggat : ${task.endDate}'),
    //           spaceHeightNormal,
    //           Text(
    //             task.title,
    //             style: AppTextStyle.tsBodyBold(AppColor.black),
    //             textAlign: TextAlign.justify,
    //           ),
    //           spaceHeightExtraSmall,
    //           Text(
    //             task.desc.join('\n'),
    //             style: AppTextStyle.tsSmallRegular(AppColor.black),
    //             textAlign: TextAlign.justify,
    //           ),
    //           spaceHeightNormal,
    //           Obx(() {
    //             if (controller.isLoading.value){
    //               return Center(
    //                 child: CircularProgressIndicator(),
    //               );
    //             }
    //             else if (controller.task!.media.isNotEmpty) {
    //               return Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     'Lampiran : ',
    //                     style: AppTextStyle.tsSmallBold(AppColor.black),
    //                   ),
    //                   spaceHeightExtraSmall,
    //                   ListView.builder(
    //                     shrinkWrap: true,
    //                     physics: NeverScrollableScrollPhysics(),
    //                     itemCount: task.media.length,
    //                     itemBuilder: (context, index) {
    //                       final media = task.media[index];
    //                       return GestureDetector(
    //                         onTap: () {
    //                           // Handle media tap
    //                         },
    //                         child: Row(
    //                           children: [
    //                             Container(
    //                               height: 60,
    //                               width: 60,
    //                               decoration: BoxDecoration(
    //                                 color: AppColor.grey,
    //                               ),
    //                               child: Image.network(
    //                                 'https://talentaku.site/image/task/${media.fileName}',
    //                                 fit: BoxFit.cover,
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       );
    //                     },
    //                   ),
    //                 ],
    //               );
    //             } else {
    //               return SizedBox();
    //             }
    //           }),
    //           spaceHeightNormal,
    //           Obx(() {
    //              if (controller.isLoading.value){
    //               return Center(
    //                 child: CircularProgressIndicator(),
    //               );
    //             }
    //             else if (controller.task!.links.isNotEmpty) {
    //               return Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     'Links : ',
    //                     style: AppTextStyle.tsSmallBold(AppColor.black),
    //                   ),
    //                   spaceHeightExtraSmall,
    //                   ListView.builder(
    //                     shrinkWrap: true,
    //                     physics: NeverScrollableScrollPhysics(),
    //                     itemCount: task.links.length,
    //                     itemBuilder: (context, index) {
    //                       final link = task.links[index];
    //                       return GestureDetector(
    //                         onTap: () {
    //                           // Handle link tap
    //                         },
    //                         child: Row(
    //                           children: [
    //                             Icon(
    //                               Icons.link,
    //                               size: 24,
    //                             ),
    //                             Expanded(
    //                               child: Padding(
    //                                 padding: const EdgeInsets.all(8.0),
    //                                 child: Text(
    //                                   link.url,
    //                                   style: AppTextStyle.tsSmallRegular(AppColor.black),
    //                                   textAlign: TextAlign.justify,
    //                                 ),
    //                               ),
    //                             )
    //                           ],
    //                         ),
    //                       );
    //                     },
    //                   ),
    //                 ],
    //               );
    //             } else {
    //               return SizedBox();
    //             }
    //           }),
    //           spaceHeightNormal,
    //           Divider(),
    //           spaceHeightSmall,
    //           Text('Tugas Ananda', style: AppTextStyle.tsSmallBold(AppColor.black)),        
    //           spaceHeightExtraSmall,
    //           // Obx(() => Wrap(
    //           //     // mainAxisAlignment: MainAxisAlignment.start ,
    //           //     spacing: 8.0,
    //           //     runSpacing: 8.0,
    //           //     children: controller.submissionFiles
    //           //         .map((file) => Image.file(File(file.path), width: 60, height: 80, fit: BoxFit.cover))
    //           //         .toList(),
    //           //   )),
    //           spaceHeightExtraSmall,
    //           Divider(),
    //         SizedBox(height: 8.0),
    //         Text(
    //           'Nilai Tugas:',
    //           style: AppTextStyle.tsSmallBold(AppColor.black),
    //         ),
    //         SizedBox(height: 8.0),
    //         // Row(
    //         //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //         //   children: [
    //         //     ElevatedButton(
    //         //       onPressed: () {
    //         //         controller.scoringSubmission(
    //         //           controller.submission.value.submissionId.toString(),
                      
    //         //         );
    //         //       }, 
    //         //       child: Text('A'),
    //         //     ),
    //         //     ElevatedButton(
    //         //       onPressed: () {
    //         //         controller.scoringSubmission(
    //         //           controller.submission.value.submissionId.toString(),
    //         //           'B',
    //         //         );
    //         //       },
    //         //       child: Text('B'),
    //         //     ),
    //         //     ElevatedButton(
    //         //       onPressed: () {
    //         //         controller.scoringSubmission(
    //         //           controller.submission.value.submissionId.toString(),
    //         //           'C',
    //         //         );
    //         //       },
    //         //       child: Text('C'),
    //         //     ),
    //         //   ],
    //         // ),
    //         ],
    //       )),
    // );
  }
}