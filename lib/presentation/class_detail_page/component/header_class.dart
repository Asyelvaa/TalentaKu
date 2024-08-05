import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';
import '../../profile_user/controllers/profile_user.controller.dart';
import '../controllers/class_detail.controller.dart';

class HeaderClass extends GetView<ProfileUserController> {
  const HeaderClass({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClassDetailController());


    return Container(
      height: 100,
      width: widthScreen,
      decoration: BoxDecoration(
          color: AppColor.blue600,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24))),
      // child: Padding(
      //   padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
      //   child: Obx(() {
      //     if (controller.isLoading.value) {
      //       return Center(child: CircularProgressIndicator());
      //     }
      //     if (controller.students.isEmpty) {
      //       return Center(child: Text("Tidak ada murid"));
      //     }
      //     return ListView.builder(
      //       scrollDirection: Axis.horizontal,
      //       itemCount: controller.students.length,
      //       itemBuilder: (context, index) {
      //         final student = controller.students[index];
      //         final isSelected = controller.selectedStudents.contains(student);
      //         final storedImage = controller.image.value;
      //         return GestureDetector(
      //           onTap: () {
      //             controller.toggleSelection(student);
      //             Get.toNamed(Routes.PROFILE_USER, arguments: controller.students[index]);
      //           },
      //           child: Column(
      //             children: [
      //               CircleAvatar(
      //                 radius: 30,
      //                 backgroundImage: storedImage != null
      //                     ? FileImage(storedImage)
      //                     : student.photo != null
      //                         ? NetworkImage(student.photo!)
      //                         : AssetImage('assets/images/anak.png')
      //                             as ImageProvider,
      //                 backgroundColor: isSelected ? Colors.blue : Colors.grey,
      //               ),
      //               SizedBox(height: 5),
      //               Text(student.name,
      //                   style: AppTextStyle.tsNormal
      //                       .copyWith(color: AppColor.white)),
      //             ],
      //           ),
      //         );
      //       },
      //     );
      //   }),
      // ),
      // child: Padding(
      //   padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
      //   child: Obx(() {
      //     return ListView.builder(
      //       shrinkWrap: true,
      //       itemCount: controller.classMembers.length,
      //       scrollDirection: Axis.horizontal,
      //       itemBuilder: (context, index) {
      //         final profile = controller.classMembers[index];
      //         return ProfileNameAvatar(
      //           name: profile.name!,
      //           profile: profile.photo! ?? '',
      //         );
      //       },
      //     );
      //   }),
      // ),
    );
  }
}
