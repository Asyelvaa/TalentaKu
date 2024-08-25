import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/home_page/controllers/home_page.controller.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';
import 'edit_program.dart';
import 'header_content.dart';

class SlideContact extends GetView<HomePageController> {
  final String headerContent;
  final List<dynamic> contentTitles;
  final List<dynamic> contentDesc;
  final void Function()? onTap;
  final String image;

  const SlideContact({
    super.key,
    this.onTap,
    required this.headerContent,
    required this.image,
    required this.contentTitles,
    required this.contentDesc,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          HeaderContent(text: headerContent, imageName: image),
          Container(
            padding: EdgeInsets.only(left: 20),
            width: widthScreen,
            height: 100,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: contentTitles.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                String contentDescription;
                if (index < contentDesc.length) {
                  contentDescription = contentDesc[index];
                } else {
                  contentDescription = 'Tidak ada deskripsi';
                }

                return Content(
                  contentTitle: contentTitles[index],
                  contentDesc: contentDescription,
                  index: index,
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

class Content extends GetView<HomePageController> {
  final String contentTitle;
  final String contentDesc;
  final int index;

  const Content({
    required this.index,
    super.key,
    required this.contentDesc,
    required this.contentTitle,
  });

  void _showEditPopup(BuildContext context) {
    final program = controller.programs[index];
    Get.dialog(
      EditProgramPopup(
        programId: program['id'],
        initialName: program['name'],
        initialDesc: program['desc'],
        // initialPhoto: program['photo'],
        initialCategoryId: int.parse(program['category_id']),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () => _showEditPopup(context),
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Container(
          height: 90,
          decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColor.blue600, width: 1)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(contentTitle, style: AppTextStyle.tsBodyBold(AppColor.black)),
                Text(
                  contentDesc.replaceAll('\\n', '\n'),
                  style: AppTextStyle.tsBodyRegular(AppColor.black),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
