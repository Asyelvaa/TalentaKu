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
          // height: heightScreen * 0.43,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(22),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
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
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(controller.announcementsList[0]['user']['name'],
                              style: AppTextStyle.tsBodyBold(AppColor.black)),
                          Text(
                              DateFormat('dd MMMM yyyy', 'id_ID;').format(
                                  DateTime.parse(controller.announcementsList[0]
                                          ['created_at']
                                      .toString())),
                              style:
                                  AppTextStyle.tsSmallRegular(AppColor.black)),
                        ],
                      ),
                    ),
                  ],
                ),
                spaceHeightExtraSmall,
                Column(
                  children: [
                    for (int i = 0; i < controller.anounces.length; i++)
                      Text(controller.anounces[i],
                          style: AppTextStyle.tsBodyRegular(AppColor.black)),
                  ],
                ),
                // spaceHeightExtraSmall,
                // ListView.builder(
                //   itemCount: controller.mediaAnnounce.length,
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemBuilder: (context, index) {
                //     var media = controller.mediaAnnounce[index];
                //     Container(
                //         child: Image.network(
                //             'https://talentaku.site/image/announcement-media/${media['file_name']}'));
                //   },
                // ),
                defaultHeightSpace,
                Divider(
                  color: AppColor.black,
                  height: 2,
                ),
                spaceHeightSmall,
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        style: AppTextStyle.tsBodyRegular(AppColor.black),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * 0.01,
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.03,
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: AppColor.black),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  const BorderSide(color: AppColor.blue500),
                            ),
                            border: const OutlineInputBorder(
                              borderSide: BorderSide(color: AppColor.blue500),
                            ),
                            fillColor: AppColor.black,
                            hintText: "Tambahkan Komentar",
                            hintStyle:
                                AppTextStyle.tsSmallRegular(AppColor.black)),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // Handle send action
                      },
                      icon: Icon(Icons.send, color: AppColor.black),
                    ),
                  ],
                ),
                spaceHeightExtraSmall,
                Text(
                  "Lihat 2 Komentar",
                  style: AppTextStyle.tsSmallRegular(AppColor.black),
                )
              ],
            ),
          ),
        ),
        SizedBox(height: 12)
      ],
    );
  }
}
