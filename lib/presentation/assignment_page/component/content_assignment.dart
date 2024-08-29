import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/models/task_model.dart';
import '../../../infrastructure/theme/theme.dart';
import '../../common_widget/custom_popup_dialog.dart';
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
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 20,
                          color: AppColor.red,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Text('Tenggat : ',
                            style: AppTextStyle.tsSmallBold(AppColor.black)),
                        Text(
                          DateFormat('EEEE, d MMMM yyyy', 'id_ID')
                                  .format(task.endDate!) ??
                              '',
                          style: AppTextStyle.tsSmallRegular(AppColor.black),
                        )
                      ],
                    ),
                    spaceHeightNormal,
                    Row(
                      children: [
                        Icon(Icons.assignment, color: AppColor.blue600),
                        defaultWidthtSpace,
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: heightScreen * 0.01,
                                horizontal: widthScreen * 0.05),
                            decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: defaultBorderRadius),
                            child: Text(
                              task.title! ?? '',
                              style: AppTextStyle.tsBodyBold(AppColor.black),
                              // textAlign: TextAlign.justify,
                              maxLines: null,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                      ],
                    ),
                    spaceHeightExtraSmall,
                    Text(
                     'Deskripsi tugas: ${ task.desc!.join('\n')}' ?? '',
                      style: AppTextStyle.tsBodyRegular(AppColor.black),
                      textAlign: TextAlign.start,
                    ),
                    spaceHeightNormal,
                    if (task.media!.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Wrap(
                            runSpacing: 8,
                            spacing: 8,
                            children: task.media!.map((media) {
                              return GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => Dialog(
                                      child: InteractiveViewer(
                                        child: Image.network(
                                          'https://talentaku.site/image/task/${media.fileName}',
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    'https://talentaku.site/image/task/${media.fileName}',
                                    width: widthScreen * 0.3,
                                    height: heightScreen * 0.15,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),

                    // Links section
                    spaceHeightExtraSmall,
                    if (task.links!.isNotEmpty)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [                          
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: task.links!.length,
                            itemBuilder: (context, index) {
                              final link = task.links![index];
                              return GestureDetector(
                                onTap: () async {
                                  final url = link.url!;
                                  final uri = Uri.tryParse(url);
                                  if (uri != null && await launchUrl(uri)) {
                                    await launchUrl(uri);
                                  } else {
                                    throw 'Could not launch $url';
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 8),
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColor.white,
                                    borderRadius: defaultBorderRadius,
                                  ),
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
                                            link.url!,
                                            style: AppTextStyle.tsSmallRegular(
                                                AppColor.black),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                  ],
                ),
                spaceHeightNormal,
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showCustomPopupDialog(
                          'Konfirmasi',
                          'Apakah Anda yakin ingin menghapus tugas ini?',
                          [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: AppColor.white),
                              onPressed: () => Get.back(),
                              child: Text(
                                'Tidak',
                                style:
                                    AppTextStyle.tsBodyRegular(AppColor.black),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  backgroundColor: AppColor.blue600),
                              onPressed: () async {
                                Get.back();
                                await controller.deleteTask(task.id.toString());
                              },
                              child: Text(
                                'Hapus Tugas',
                                style:
                                    AppTextStyle.tsBodyRegular(AppColor.white),
                              ),
                            ),
                          ],
                        );
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
                    // ElevatedButton(
                    //   onPressed: () async {
                    //     // await controller.updateTask();
                    //   },
                    //   child: Center(
                    //     child: Text(
                    //       'Edit Tugas',
                    //       style: AppTextStyle.tsSmallBold(AppColor.white),
                    //     ),
                    //   ),
                    //   style: ElevatedButton.styleFrom(
                    //     fixedSize: Size.fromHeight(44),
                    //     elevation: 0,
                    //     backgroundColor: AppColor.blue600,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.circular(16),
                    //     ),
                    //   ),
                    // ),
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
