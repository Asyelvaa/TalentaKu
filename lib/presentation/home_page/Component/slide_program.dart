import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/common_widget/text_background.dart';
import 'package:flutter_talentaku/presentation/home_page/controllers/home_page.controller.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';
import '../models/program_data.dart';
import 'header_content.dart';
import 'home_bottomsheet_information.dart';

import 'package:flutter/material.dart';

class SlideInformation extends StatelessWidget {
  final String headerContent;
  final List<String> contentTitles; // Pastikan parameter ini ada
  final void Function()? onTap;
  final String image;

  const SlideInformation({
    Key? key,
    required this.headerContent,
    required this.contentTitles,
    this.onTap,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          HeaderContent(text: headerContent, imageName: image),
          Container(
            padding: EdgeInsets.only(left: 20),
            width: double.infinity,
            height: 100,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: contentTitles.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: onTap,
                  child: Content(
                    contentTitle: contentTitles[index],
                    index: index,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


class Content extends GetView<HomePageController> {
  final String contentTitle;
  final int index;

  const Content({
    required this.index,
    super.key,
    required this.contentTitle,
  });

  void _showProgramDetails(BuildContext context, Program program) {
    Get.bottomSheet(
      HomeBottomsheetInformation(
        informationTitle: controller.programs[index]['name'],
        photoList: program.photos,
        descriptionContent: controller.programs[index]['desc'], programId: 1,
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    final program = mockProgramData.firstWhere(
      (program) => program.title == contentTitle,
      orElse: () => Program(
        title: 'Not Found',
        description: 'No description available',
        photos: [],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColor.blue600, width: 1)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(contentTitle, style: AppTextStyle.tsNormal),
              GestureDetector(
                onTap: () {
                  _showProgramDetails(context, program);
                },
                child: TextWithBackground(
                  colorBackground: AppColor.blue100,
                  text: "Check it",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
