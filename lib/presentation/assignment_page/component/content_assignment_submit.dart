import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../infrastructure/theme/theme.dart';
import '../../common_widget/text_background.dart';
import '../controllers/assignment_page.controller.dart';
import 'circular_icon_button.dart';

class ContentAssignmentSubmit extends GetView<AssignmentPageController> {
  const ContentAssignmentSubmit({super.key});

  @override
  Widget build(BuildContext context) {
    var task = controller.task!;
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.symmetric(vertical: heightScreen * 0.02, horizontal: widthScreen * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWithBackground(
                  colorBackground: AppColor.grey,
                  text: 'Tengggat : ${task.endDate}'),
              spaceHeightNormal,
              Text(
                task.title,
                style: AppTextStyle.tsBodyBold(AppColor.black),
                textAlign: TextAlign.justify,
              ),
              spaceHeightExtraSmall,
              Text(
                task.desc.join('\n'),
                style: AppTextStyle.tsSmallRegular(AppColor.black),
                textAlign: TextAlign.justify,
              ),
              spaceHeightNormal,
              Obx(() {
                if (controller.isLoading.value){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if (controller.task!.media.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lampiran : ',
                        style: AppTextStyle.tsSmallBold(AppColor.black),
                      ),
                      spaceHeightExtraSmall,
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: task.media.length,
                        itemBuilder: (context, index) {
                          final media = task.media[index];
                          return GestureDetector(
                            onTap: () {
                              // Handle media tap
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    color: AppColor.grey,
                                  ),
                                  child: Image.network(
                                    'https://talentaku.site/image/task/${media.fileName}',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  return SizedBox();
                }
              }),
              spaceHeightNormal,
              Obx(() {
                 if (controller.isLoading.value){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                else if (controller.task!.links.isNotEmpty) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Links : ',
                        style: AppTextStyle.tsSmallBold(AppColor.black),
                      ),
                      spaceHeightExtraSmall,
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: task.links.length,
                        itemBuilder: (context, index) {
                          final link = task.links[index];
                          return GestureDetector(
                            onTap: () {
                              // Handle link tap
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.link,
                                  size: 24,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      link.url,
                                      style: AppTextStyle.tsSmallRegular(AppColor.black),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  );
                } else {
                  return SizedBox();
                }
              }),
              spaceHeightNormal,
              Divider(),
              spaceHeightSmall,
              Row(
                children: [
                  CircularIconButton(
                        icon: Icons.file_upload, 
                        onPressed: () => controller.pickSubmissionMedia(ImageSource.gallery)
                      ),
                  defaultWidthtSpace,
                  Text('Upload Tugas Kamu: '),
                ],
              ),              
              spaceHeightExtraSmall,
              Obx(() => Wrap(
                  // mainAxisAlignment: MainAxisAlignment.start ,
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: controller.submissionFiles
                      .map((file) => Image.file(File(file.path), width: 60, height: 80, fit: BoxFit.cover))
                      .toList(),
                )),
              spaceHeightExtraSmall,
              ElevatedButton(
                onPressed: () async {
                  await controller.submitTask(task.id.toString());
                  print('submit task with id ${task.id}');
                },
                child: Center(
                  child: Text(
                    'Kumpulkan Tugas',
                    style: AppTextStyle.tsSmallBold(AppColor.white),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size.fromHeight(44),
                  elevation: 0,
                  backgroundColor: AppColor.blue600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}