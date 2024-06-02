import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';
import '../models/information_data.dart';
import 'home_popup_infromation.dart';

class VisiMisiComponent extends StatelessWidget {
  const VisiMisiComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          Get.dialog(HomePopupInformation(information: informationMockupData[0]));
        },
        child: Container(
          padding: EdgeInsets.all(20),
          height: 210,
          decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                  color: AppColor.blue500, width: 1),
              color: AppColor.white),
          child: Text("Visi & \nMisi",
              textAlign: TextAlign.start,
              style: AppTextStyle.tsTitle),
        ),
      ),
    );
  }
}

