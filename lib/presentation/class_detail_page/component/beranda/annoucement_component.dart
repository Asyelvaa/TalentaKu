import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/controllers/class_detail.controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../common_widget/custom_popup_dialog.dart';
import 'pdf_widget.dart';
import 'widget_display_picked_file.dart';

class AnnouncementComponent extends GetView<ClassDetailController> {
  const AnnouncementComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClassDetailController());
    return Container(
      width: Get.width,
      child: Obx(() {
        if (controller.announcementsList.isEmpty) {
          return Center(
              child: Text(
            "Belum ada pengumuman kelas",
            style: AppTextStyle.tsBodyRegular(AppColor.black),
          ));
        }
        if (controller.isLoading.value) {
          return CircularProgressIndicator();
        }
        return ListView.builder(
            itemCount: controller.announcementsList.length,
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var announcement = controller.announcementsList[index];
              return Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: AppColor.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColor.blue500,
                              ),
                            ),
                            defaultWidthtSpace,
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    announcement['user']['name'],
                                    style:
                                        AppTextStyle.tsBodyBold(AppColor.black),
                                  ),
                                  Text(
                                    DateFormat('dd MMMM yyyy', 'id_ID').format(
                                      DateTime.parse(announcement['created_at']
                                          .toString()),
                                    ),
                                    style: AppTextStyle.tsSmallRegular(
                                        AppColor.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        PopupMenuButton<int>(
                          icon: Icon(Icons.more_vert, color: AppColor.black),
                          onSelected: (value) {
                            if (value == 1) {
                              // showDeleteConfirmationDialog(context, announcement['id']);
                              print(announcement['id']);
                              controller.deleteAnnouncement(announcement['id']);
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem(
                              value: 1,
                              child: Row(
                                children: [
                                  Icon(Icons.delete_forever,
                                      color: AppColor.red),
                                  SizedBox(width: 8),
                                  Text(
                                    'Hapus Pengumuman',
                                    style: AppTextStyle.tsSmallRegular(
                                        AppColor.black),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          color: AppColor.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ],
                    ),
                    spaceHeightExtraSmall,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...announcement['announcements']
                            .map<Widget>((announcment) {
                          return Text(
                            announcment ?? '',
                            style: AppTextStyle.tsBodyRegular(AppColor.black),
                          );
                        })
                      ],
                    ),
                    spaceHeightExtraSmall,
                    if (announcement['media'].isNotEmpty)
                      ...announcement['media'].map<Widget>((media) {
                        String fileName = media['file_name'];
                        String fileExtension =
                            fileName.split('.').last.toLowerCase();
                        String fileUrl =
                            'https://talentaku.site/image/announcement-media/$fileName';

                        if (['jpg', 'jpeg', 'png'].contains(fileExtension)) {
                          return Container(
                            height: heightScreen * 0.2,
                            padding: const EdgeInsets.only(top: 8.0),
                            child : Image.network(
                              fileUrl,
                              fit: BoxFit.scaleDown,
                            ),
                            // child: GestureDetector(
                            // onTap: () {
                            //   showGeneralDialog(
                            //     context: context,
                            //     barrierDismissible: true,
                            //     barrierLabel:MaterialLocalizations.of(context).modalBarrierDismissLabel,
                            //     barrierColor: AppColor.black,
                            //     pageBuilder:(BuildContext context, Animation first, Animation second) {
                            //       return Scaffold(
                            //         backgroundColor: Colors.transparent,
                            //         body: Column(
                            //           children: [
                            //             IconButton(
                            //               icon: Icon(Icons.close, color: Colors.white),
                            //               onPressed: () => Get.back(),
                            //             ),
                            //             SizedBox(height: 16.0),
                            //             InteractiveViewer(                                        
                            //               child: Image.network(
                            //                 fileUrl,
                            //                 fit: BoxFit.contain,
                            //               ),
                            //             ),
                            //           ],
                            //         ),  
                            //       ); }                               
                            //   );
                            // }                                                  
                          // )
                          );
                        } else if (fileExtension == 'pdf') {
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: PDFWidget(
                              fileUrl: fileUrl,
                              fileName: fileName,
                            ),
                          );
                        } else {
                          return SizedBox();
                        }
                      }).toList(),
                    // defaultHeightSpace,
                    // Divider(
                    //   color: AppColor.black,
                    //   height: 2,
                    // ),
                    // spaceHeightSmall,
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: TextFormField(
                    //         style: AppTextStyle.tsBodyRegular(
                    //             AppColor.black),
                    //         decoration: InputDecoration(
                    //           contentPadding: EdgeInsets.symmetric(
                    //             vertical:
                    //                 MediaQuery.of(context).size.height *
                    //                     0.01,
                    //             horizontal:
                    //                 MediaQuery.of(context).size.width *
                    //                     0.03,
                    //           ),
                    //           enabledBorder: const OutlineInputBorder(
                    //             borderSide:
                    //                 BorderSide(color: AppColor.black),
                    //             borderRadius:
                    //                 BorderRadius.all(Radius.circular(12)),
                    //           ),
                    //           focusedBorder: OutlineInputBorder(
                    //             borderRadius: BorderRadius.circular(12),
                    //             borderSide: const BorderSide(
                    //                 color: AppColor.blue500),
                    //           ),
                    //           border: const OutlineInputBorder(
                    //             borderSide:
                    //                 BorderSide(color: AppColor.blue500),
                    //           ),
                    //           fillColor: AppColor.black,
                    //           hintText: "Tambahkan Komentar",
                    //           hintStyle: AppTextStyle.tsSmallRegular(
                    //               AppColor.black),
                    //         ),
                    //       ),
                    //     ),
                    //     IconButton(
                    //       onPressed: () {
                    //         // Handle send action
                    //       },
                    //       icon: Icon(Icons.send, color: AppColor.black),
                    //     ),
                    //   ],
                    // ),
                    // spaceHeightExtraSmall,
                    // Text(
                    //   "Lihat ${announcement['replies_count']} Komentar",
                    //   style: AppTextStyle.tsSmallRegular(AppColor.black),
                    // ),
                  ],
                ),
              );
            });
      }),
    );
  }

  void showDeleteConfirmationDialog(BuildContext context, String announcementId) {
    showCustomPopupDialog(
      'Konfirmasi',
      'Apakah Anda yakin ingin menghapus anggota ini dari kelas?',
      [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            'Tidak',
            style: AppTextStyle.tsBodyRegular(AppColor.black),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            controller.deleteAnnouncement(announcementId);
            print(announcementId);
          },
          child: Text(
            'Iya, Hapus',
            style: AppTextStyle.tsBodyRegular(AppColor.red),
          ),
        ),
      ],
    );
  }
}
