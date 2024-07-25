import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

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
    // final List<String> userRole = (GetStorage().read('role') ?? []).cast<String>();
    return GestureDetector(
      onTap: (){
        if (controller.userRole.any((role) => role == 'Guru KB' || role == 'Guru SD')) {
          _showAddClassBottomSheet(context);
        } else if (controller.userRole.any((role) => role == 'Murid KB' || role == 'Murid SD')) {
          _showJoinClassBottomSheet(context);
        } else {
          Get.snackbar("Gagal", "Anda tidak memiliki role akses");
        }
      },
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColor.blue100,
          borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
              "assets/images/logo_talentaku.png", scale: 20,),
            ),
            Text(
              "Klik bagian ini untuk mendapatkan kelas baru",
              style: AppTextStyle.tsLittle,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }
}
