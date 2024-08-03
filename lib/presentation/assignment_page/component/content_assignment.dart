import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../domain/models/task_model.dart';
import '../../../infrastructure/theme/theme.dart';
import '../../common_widget/text_background.dart';
import '../controllers/assignment_page.controller.dart';
import 'circular_icon_button.dart';

class ContentAssignment extends GetView<AssignmentPageController> {
  ContentAssignment({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (controller.taskDetail.value == null) {
            return Center(
              child: Text("Task not found"),
            );
          } else {
            final task = controller.taskDetail.value!;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWithBackground(
                    colorBackground: AppColor.grey,
                    text: 'Tengggat : ${task.endDate}'),
                spaceHeightNormal,
                Text(
                  task.title!,
                  style: AppTextStyle.tsBodyBold(AppColor.black),
                  textAlign: TextAlign.justify,
                ),
                spaceHeightExtraSmall,
                Text(
                  task.desc!.join('\n'),
                  style: AppTextStyle.tsSmallRegular(AppColor.black),
                  textAlign: TextAlign.justify,
                ),
                spaceHeightNormal,
                if (task.media!.isNotEmpty)
                  Column(
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
                        itemCount: task.media!.length,
                        itemBuilder: (context, index) {
                          final media = task.media![index];
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
                  ),
                spaceHeightNormal,
                if (task.links!.isNotEmpty)
                  Column(
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
                        itemCount: task.links!.length,
                        itemBuilder: (context, index) {
                          final link = task.links![index];
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
                  ),
                spaceHeightNormal,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        await controller.deleteTask(task.id.toString());
                      },
                      child: Center(
                        child: Text(
                          'Hapus Tugas',
                          style: AppTextStyle.tsSmallBold(AppColor.white),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size.fromHeight(44),
                        elevation: 0,
                        backgroundColor: AppColor.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        // await controller.updateTask();
                      },
                      child: Center(
                        child: Text(
                          'Edit Tugas',
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
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
