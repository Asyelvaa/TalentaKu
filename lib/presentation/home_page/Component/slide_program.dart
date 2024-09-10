import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/common_widget/text_background.dart';
import 'package:flutter_talentaku/presentation/home_page/Component/add_new_data.dart';
import 'package:flutter_talentaku/presentation/home_page/controllers/home_page.controller.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../infrastructure/theme/theme.dart';
import '../models/program_data.dart';
import 'header_content.dart';
import 'home_bottomsheet_information.dart';

class SlideInformation extends GetView<HomePageController> {
  final String headerContent;
  final List<String> contentTitles;
  final void Function()? onTap;
  final String image;

  SlideInformation({
    Key? key,
    required this.headerContent,
    required this.contentTitles,
    this.onTap,
    required this.image,
  }) : super(key: key);
  final HomePageController _homePageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          HeaderContent(text: headerContent, imageName: image),
          Wrap(
            spacing: 10, 
            runSpacing: 10, 
            children: [
              ...contentTitles.map((title) => 
                  GestureDetector(
                    onTap: onTap, 
                    child: Content(
                      contentTitle: title,
                      index: contentTitles.indexOf(title),
                    ),
                  )
                ),
              // ADD BUTTON
              if (_homePageController.userRole
                  .any((role) => role.contains('Guru')))
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.black12,
                      builder: (BuildContext context) {
                        return Container(
                          height: heightScreen * 0.7,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.horizontal(
                                right: Radius.circular(22)),
                            color: AppColor.white,
                          ),
                          child: AddNewData(
                            initialName: controller.nameController.text,
                            initialDesc: controller.descController.text,
                            initialPhoto: controller.selectedImages.value,
                            initialCategoryId: 1.toString(),
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    height: heightScreen * 0.2,
                    width: widthScreen * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColor.white,
                      border: Border.all(color: AppColor.blue600, width: 1),
                    ),
                    child: Icon(Icons.add, size: 30),
                  ),
                )
            ],
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
    return GestureDetector(
      onTap: () {
         _showProgramDetails(context, controller.programs[index]);
      },
      child: Container(
        width: widthScreen * 0.45,
        // height: 90,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical:8),
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColor.blue600, width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(contentTitle, style: AppTextStyle.tsNormal, textAlign: TextAlign.center,),
            spaceHeightSmall,
            Obx((){
              if (controller.isLoading.value) {
                return Shimmer(
                  color: Colors.grey.shade400,
                  child: Container(
                    width: Get.width,
                    height: heightScreen * 0.15,
                    decoration: BoxDecoration(
                      borderRadius: defaultBorderRadius,
                      color: AppColor.grey,
                    ),
                  ),
                );
              } else {
              final program = controller.programs[index];
              final programPhoto = program['photo'] ?? '';
              return Container(
                width : Get.width,
                height:  heightScreen * 0.15,
                decoration: BoxDecoration(
                  borderRadius: defaultBorderRadius
                ),
                child: (programPhoto == null || programPhoto.isEmpty)
                  ? Container(                        
                        decoration: BoxDecoration(
                          borderRadius: defaultBorderRadius,
                          color: AppColor.grey,
                        ),
                        child: Center(
                          child: Text(
                            'Tidak ada foto', 
                            style: AppTextStyle.tsSmallRegular(AppColor.black),
                          )),
                      )
                  : GestureDetector(
                          child: Container(
                            height: heightScreen,
                            width: widthScreen,
                            padding: const EdgeInsets.all(1),
                            child: Image.network(
                              'https://talentaku.site/image/program/$programPhoto',
                              fit: BoxFit.scaleDown,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey,
                                  child: const Icon(
                                    Icons.error,
                                    color: Colors.red,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
              );
              }
            }),            
          ],
        ),
      ),
    );
  }
}
