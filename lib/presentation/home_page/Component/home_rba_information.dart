import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/home_page/Component/home_popup_rba.dart';
import 'package:flutter_talentaku/presentation/home_page/controllers/home_page.controller.dart';
import 'package:get/get.dart';
import '../../../infrastructure/theme/theme.dart';
import '../models/information_data.dart';
import 'home_popup_infromation.dart';
import 'home_popup_kbsd.dart';

class RbaTalentaComponent extends GetView<HomePageController> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: GestureDetector(
        onTap: () {
          if (controller.informationList.isNotEmpty) {
            final information = controller.informationList.firstWhere(
              (info) => info.informationTitle == "Rumah Belajar Anak",
              orElse: () => Information(
                informationTitle: "Rumah Belajar Anak",
                informationData: [],
              ),
            );
            Get.dialog(HomePopupRba(information: information));
          } else {
            print("Information data is not available");
          }
        },
        child: Stack(
          children: [
            Container(
              width: widthScreen * 0.5,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                border: Border.all(color: AppColor.blue500, width: 1),
                color: AppColor.blue700,
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("Rumah Belajar Anak",
                    textAlign: TextAlign.start,
                    style:
                        AppTextStyle.tsNormal.copyWith(color: AppColor.white)),
              ),
            ),
            Positioned(
              child: Image.asset('assets/images/bottom2.png'),
              top: 70,
            ),
          ],
        ),
      ),
    );
  }
}
