import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:iconsax/iconsax.dart';

import '../../../infrastructure/theme/theme.dart';
import '../controllers/class_page.controller.dart';
import 'add_class_bottomsheet.dart';
import 'join_class_bottomsheets.dart';

class ButtonClassForm extends GetView<ClassController> {
  const ButtonClassForm({
    super.key,
  });
  void _showAddClassBottomSheet(BuildContext context) {
    Get.bottomSheet(
      AddClassBottomSheet(),
      isScrollControlled: true,
    );
  }

   void _showJoinClassBottomSheet(BuildContext context) {
    Get.bottomSheet(
      JoinClassBottomsheets(),
      isScrollControlled: true,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        var userRole = controller.userRole;
        if (userRole.any((role) => role.contains('Guru'))) {
          _showAddClassBottomSheet(context);
        } else if (userRole.any((role) => role.contains('Murid'))) {
          _showJoinClassBottomSheet(context);
        } else {
          Get.snackbar("Gagal", "Anda tidak memiliki role akses");
        }
      },
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColor.blue700,
          borderRadius: defaultBorderRadius,),
          padding: EdgeInsets.symmetric(
            vertical: heightScreen * 0.02, 
            horizontal: widthScreen * 0.03
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(Iconsax.add, color: AppColor.white, weight: 28,),
            Expanded(
              child: AutoSizeText(
                "Klik bagian ini untuk mendapatkan kelas baru",
                style: AppTextStyle.tsSmallBold(AppColor.white),
                maxLines: 1,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
