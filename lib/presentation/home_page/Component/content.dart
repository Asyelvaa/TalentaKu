import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/home_page/Component/HomeBottomSheetExtra.dart';
import 'package:flutter_talentaku/presentation/home_page/models/program_extra.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../../infrastructure/theme/theme.dart';
import '../../common_widget/text_background.dart';
import '../controllers/home_page.controller.dart';
import 'home_bottomsheet_information.dart';

class Content extends GetView<HomePageController> {
  final String contenExtra;
  final int index;

  const Content({
    required this.index,
    super.key,
    required this.contenExtra,
  });

  void _showProgramDetails(BuildContext context, extra) {
    Get.bottomSheet(
      HomeBottomSheetExtra(
        informationTitleExtra: extra['name'],
        photoListExtra: extra['photo'] ?? '',
        descriptionContentExtra: extra['desc'].join(', '),
        extraId: extra['id'],
      ),
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: () {
         _showProgramDetails(context, controller.extra[index]);
      },
      child: Container(
        width: widthScreen * 0.45,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical:8),
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColor.blue600, width: 1)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(contenExtra, style: AppTextStyle.tsNormal, textAlign: TextAlign.center),
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
            final program = controller.extra[index] ?? 0;
            final programPhoto = program['photo'];
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
