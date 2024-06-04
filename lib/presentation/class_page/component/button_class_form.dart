import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';
import '../controllers/class_page.controller.dart';
import 'add_class_bottomsheet.dart';
import 'join_class_bottomsheets.dart';

class ButtonClassForm extends GetView<ClassController> {
  const ButtonClassForm({
    super.key,
  });
  void _showAddClassBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AddClassBottomSheet(
          onAddClass: (newClass) {
            // controller.addClass(newClass);
          },
        );
      },
    );
  }

  void _showJoinClassBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return JoinClassBottomsheets(
          onJoinClass: (classCode) {
            // controller.joinclass(classCode);
          },
        );
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: (){
      //   if (controller.currentUser.value.role == 'teacher') {
      //     _showAddClassBottomSheet(context);
      //   } else if (controller.currentUser.value.role == 'student') {
      //     _showJoinClassBottomSheet(context);
      //   }
      // },
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColor.blue100,
          borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
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
