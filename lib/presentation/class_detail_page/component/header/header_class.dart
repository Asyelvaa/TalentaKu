import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import 'package:flutter_talentaku/presentation/common_widget/text_background.dart';
import 'package:get/get.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../../profile_user/controllers/profile_user.controller.dart';
import '../../controllers/class_detail.controller.dart';

class HeaderClass extends GetView<ProfileUserController> {
  const HeaderClass({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClassDetailController());
    return Container(
      height: heightScreen * 0.11,
      width: widthScreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            // if (controller.isLoading.value) {
            //   return Center(
            //     child: CircularProgressIndicator(
            //       color: AppColor.white,
            //     ),
            //   );
            // }
            if (controller.students.isEmpty) {
              return Expanded(
                child: Center(
                    child: Text(
                  "Kelas ini belum memiliki murid",
                  style: AppTextStyle.tsBodyRegular(AppColor.white),
                )),
              );
            }
            return Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: controller.students.length,
                itemBuilder: (context, index) {
                  final student = controller.students[index];
                  final isSelected =
                      controller.selectedStudents.contains(student);
                  final storedImage = controller.image.value;
                  return GestureDetector(
                    onTap: () {
                      if (controller.userRole
                          .any((role) => role.contains('Guru'))) {
                        controller.toggleSelection(student);
                        Get.toNamed(Routes.PROFILE_USER,
                            // arguments: {
                            //   'student': student,
                            //   'classId': controller.classItem['id']
                            // });
                            arguments: [
                              controller.students[index],
                              controller.classItem['id']
                            ]);
                      }
                    },
                    child: Container(
                      width: widthScreen * 0.2,
                      child: Column(children: [
                        CircleAvatar(
                            radius: 30,
                            backgroundColor: AppColor.white,
                            child: student.photo != null
                                // ? ClipOval(
                                //     child: Image.network(
                                //       student.photo!,
                                //       width: 30,
                                //       height: 30,
                                //       fit: BoxFit.cover,
                                //     ),
                                //   )
                                ? Image.asset(
                                    'assets/images/student.png',
                                    fit: BoxFit.cover,
                                  )
                                : AutoSizeText(
                                    getInitials(student.name!),
                                    style:
                                        AppTextStyle.tsBodyBold(AppColor.black),
                                    minFontSize: 12,
                                  )),
                        AutoSizeText(
                          student.name!,
                          style: AppTextStyle.tsSmallRegular(AppColor.white),
                          minFontSize: 12,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ]),
                    ),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}

String getInitials(String name) {
  List<String> nameParts = name.split(' ');
  if (nameParts.length == 1) {
    return nameParts[0].substring(0, 2).toUpperCase();
  } else {
    return (nameParts[0][0] + nameParts[1][0]).toUpperCase();
  }
}
