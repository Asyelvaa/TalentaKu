import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/home_page/Component/HomeBottomSheetExtra.dart';
import 'package:flutter_talentaku/presentation/home_page/models/program_extra.dart';
import 'package:get/get.dart';

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
    // final extra = Extra.fromJson(controller.programs[index]);

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
              Text(contenExtra, style: AppTextStyle.tsNormal),
              GestureDetector(
                onTap: () {
                  _showProgramDetails(context, controller.extra[index]);
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
