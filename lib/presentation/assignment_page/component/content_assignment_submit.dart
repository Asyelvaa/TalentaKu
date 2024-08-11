import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../infrastructure/theme/theme.dart';
import '../controllers/assignment_page.controller.dart';


class ContentAssignmentSubmit extends GetView<AssignmentPageController> {
  const ContentAssignmentSubmit({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (controller.taskDetail.value == null) {
        return Center(
          child: Text('Error fetching data'),
        );
      } else {
        var task = controller.taskDetail.value!;
        return Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: heightScreen * 0.02,
                horizontal: widthScreen * 0.05,
              ),
              child: Column(
                children: [
                  // DETAIL TASK
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
                          SizedBox(width: 4,),
                          Text('Tenggat : ',
                              style: AppTextStyle.tsSmallBold(
                                  AppColor.black)),
                          Text(
                            DateFormat('EEE, d MMMM yyyy').format(task.endDate!) ?? '',
                            style: AppTextStyle.tsSmallRegular(AppColor.black),
                          )
                        ],
                      ),
                      spaceHeightNormal,
                      Row(
                        children: [
                          Icon(Icons.assignment, color: AppColor.blue600),
                          defaultWidthtSpace,
                          Container(
                            padding: EdgeInsets.symmetric(vertical: heightScreen * 0.01, horizontal: widthScreen * 0.05),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: defaultBorderRadius
                            ),
                            child: Text(
                              task.title! ?? '',
                              style: AppTextStyle.tsBodyBold(AppColor.black),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                      spaceHeightExtraSmall,
                      Text(
                        task.desc!.join('\n') ?? '',
                        style: AppTextStyle.tsBodyRegular(AppColor.black),
                        textAlign: TextAlign.start,
                      ),
                      spaceHeightExtraSmall,
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
                                      if (uri != null && await canLaunchUrl(uri)) {
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
                                              style: AppTextStyle.tsSmallRegular(AppColor.black),
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
                  // UPLOAD SUBMISSION
                  Divider(color: AppColor.blue600),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.file_upload_rounded),
                        color: AppColor.blue600,
                        onPressed: () => controller.pickSubmissionMedia(source: ImageSource.gallery),
                      ),
                      Text(
                        'Upload Tugas Kamu: ',
                        style: AppTextStyle.tsBodyBold(AppColor.black),
                      ),
                    ],
                  ),
                  spaceHeightExtraSmall,
                  Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children: controller.submissionFiles.map((file) {
                              return Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () => showGeneralDialog(
                                      context: context,
                                      barrierDismissible: true,
                                      barrierLabel:
                                          MaterialLocalizations.of(context)
                                              .modalBarrierDismissLabel,
                                      barrierColor: AppColor.black,
                                      pageBuilder: (BuildContext context,
                                          Animation first, Animation second) {
                                        return Center(
                                          child: InteractiveViewer(
                                            child:
                                                Image.file(File(file.path)),
                                          ),
                                        );
                                      },
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        File(file.path),
                                        width: widthScreen * 0.3,
                                        height: heightScreen * 0.15,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    right: 4,
                                    top: 4,
                                    child: GestureDetector(
                                      onTap: () => controller
                                          .removeSubmissionMedia(file),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    );
                  }),
                  spaceHeightNormal,
                  ElevatedButton(
                    onPressed: () async {
                      await controller.submitTask(task.id!.toString());
                    },
                    child: Center(
                      child: Text(
                        'Kumpulkan Tugas',
                        style: AppTextStyle.tsBodyBold(AppColor.white),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromHeight(60),
                      elevation: 0,
                      backgroundColor: AppColor.blue600,
                      shape: RoundedRectangleBorder(
                        borderRadius: defaultBorderRadius,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    });
  }
}
