import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_talentaku/presentation/common_widget/text_background.dart';
import 'package:flutter_talentaku/presentation/home_page/Component/add_new_data.dart';
import 'package:flutter_talentaku/presentation/home_page/controllers/home_page.controller.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';
import '../models/program_data.dart';
import 'header_content.dart';
import 'home_bottomsheet_information.dart';

class SlideInformation extends GetView<HomePageController> {
  final String headerContent;
  final List<String> contentTitles;
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
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: contentTitles.length,
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
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
                GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      Container(
                          height: heightScreen * 0.5,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(22)),
                            color: AppColor.white,
                          ),
                          child: AddNewData(
                            initialName: controller.nameController.text,
                            initialDesc: controller.descController.text,
                            initialPhoto: controller.selectedImages.value,
                            initialCategoryId: controller.categoryId.text,
                          )),
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                    );
                  },
                  child: Container(
                    height: heightScreen * 0.3,
                    width: widthScreen * 0.3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColor.white),
                    child: Icon(Icons.add),
                  ),
                ),
              ],
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

  void _showProgramDetails(BuildContext context, program) {
    Get.bottomSheet(
      HomeBottomsheetInformation(
        informationTitle: program['name'],
        photoList: program['photo'] ?? '',
        descriptionContent: program['desc'].join(', '),
        programId: program['id'],
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    // final program = Program.fromJson(controller.programs[index]);
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
                  _showProgramDetails(context, controller.programs[index]);
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
