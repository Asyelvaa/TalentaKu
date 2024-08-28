import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/controllers/class_detail.controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AnnouncementComponent extends GetView<ClassDetailController> {
  const AnnouncementComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Get.width,          
          child: Obx(() {
            if (controller.announcementsList.isEmpty) {
              return Center(child: Text("Belum ada pengumuman kelas", style: AppTextStyle.tsBodyRegular(AppColor.black),));
            }
            if (controller.isLoading.value) {
              return CircularProgressIndicator();
            }
            return ListView.builder(
                itemCount: controller.announcementsList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var announcement = controller.announcementsList[index];
                  return Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.only(bottom: 20),
                     decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    announcement['user']['name'],
                                    style: AppTextStyle.tsBodyBold(
                                        AppColor.black),
                                  ),
                                  Text(
                                    DateFormat('dd MMMM yyyy', 'id_ID')
                                        .format(
                                      DateTime.parse(
                                          announcement['created_at']
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
                        spaceHeightExtraSmall,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ...announcement['announcements']
                                .map<Widget>((announcment) {
                              return Text(
                                announcment ?? '',
                                style: AppTextStyle.tsBodyRegular(
                                    AppColor.black),
                              );
                            })
                          ],
                        ),
                        spaceHeightExtraSmall,
                        // if (announcement['media'].isNotEmpty)
                        //   ...announcement['media'].map<Widget>((media) {
                        //     return Padding(
                        //       padding: const EdgeInsets.only(
                        //         top: 8.0,
                        //       ),
                        //       child: Image.network(
                        //         'https://talentaku.site/image/announcement-media/${media['file_name']}',
                        //         fit: BoxFit.cover,
                        //       ),
                        //     );
                        //   }).toList(),
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
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
