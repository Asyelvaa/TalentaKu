import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../infrastructure/theme/theme.dart';
import '../controllers/home_page.controller.dart';
import 'home_popup_infromation.dart';

class VisiMisiComponent extends StatelessWidget {
  VisiMisiComponent({super.key});

  final HomePageController controller = Get.find<HomePageController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (controller.contactandinformation.isNotEmpty) {
            Get.dialog(
              HomePopupInformation(
                information: controller.informationList[0]));
          } else {
            print("Information data is not available");
          }
        },
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              height: heightScreen * 0.24,
              width: Get.width * 0.4,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: AppColor.blue500, width: 1),
                  color: AppColor.white),
              child: Text("Visi & \nMisi",
                  textAlign: TextAlign.start, style: AppTextStyle.tsTitleBold(AppColor.black)),
            ),
            Positioned(
              child: Image.asset('assets/images/bottom2.png'),
              top: 180,
            )
          ],
        ),
      ),
    );
  }
}
