import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import 'package:get/get.dart';
import '../../infrastructure/theme/theme.dart';
import '../common_widget/appbar_username.dart';
import '../common_widget/custom_button_icon.dart';
import '../student_report_form/model/Student.dart';
import 'component/profile_data_container_user.dart';
import 'component/profile_data_user.dart';
import 'component/profile_user.dart';
import 'controllers/profile_user.controller.dart';

class ProfileUserScreen extends GetView<ProfileUserController> {
  ProfileUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileUserController controller = Get.put(ProfileUserController());
    final Student student = Get.arguments[0];
    final arguments = Get.arguments;
    controller.box.write('student_id', student.id);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppbarUsername(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              CircleAvatar(
                  radius: 60,
                  backgroundColor: AppColor.blue600,
                  child: Text(student.name.substring(2).toUpperCase(),
                      style: AppTextStyle.tsSmallBold(AppColor.white))),
              SizedBox(height: 12),
              Obx(() {
                if (controller.isLoading.value) {
                  return Column(
                    children: [
                      Text('Loading...', style: AppTextStyle.tsTitle),
                      Text(
                        'Loading...',
                        style: AppTextStyle.tsNormal
                            .copyWith(color: AppColor.blue600),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Text(
                        student.name ?? 'Unknown',
                        style: AppTextStyle.tsTitle,
                      ),
                      Text(
                        student.roles.join(', '),
                        style: AppTextStyle.tsNormal
                            .copyWith(color: AppColor.blue600),
                      ),
                    ],
                  );
                }
              }),
              defaultHeightSpace,
              Obx(() => controller.isLoading.value
                  ? Column(
                      children: [
                        ProfileList(
                          title: "Nama Lengkap",
                          description: "Loading...",
                        ),
                        ProfileList(
                          title: "NIS",
                          description: "Loading...",
                        ),
                        ProfileList(
                          title: "Kelas",
                          description: "Loading...",
                        ),
                        ProfileList(
                          title: "Alamat",
                          description: "Loading...",
                        ),
                        // ProfileList(
                        //   title: "Mulai di RBA",
                        //   description: "Loading...",
                        // ),
                      ],
                    )
                  : Column(
                      children: [
                        ProfileList(
                          title: "Nama Lengkap",
                          description: student.name ?? '-',
                        ),
                        ProfileList(
                          title: "NIS",
                          description: student.identificationNumber ?? '-',
                        ),
                        ProfileList(
                          title: "Kelas",
                          description: student.grades.isNotEmpty
                              ? student.grades[0]
                              : '-',
                        ),
                        ProfileList(
                          title: "Alamat",
                          description: student.address ?? '-',
                        ),
                        // ProfileList(
                        //   title: "Mulai di RBA",
                        //   description: '-',
                        // ),
                      ],
                    )),
              defaultHeightSpace,
              if (student.roles.contains('Murid KB') ||
                  student.roles.contains('Murid SD'))
                CustomButtonWithIcon(
                  text: "Laporan Pembelajaran",
                  icon: Icons.arrow_forward_ios,
                  colorButton: AppColor.white,
                  colorIcon: AppColor.black,
                  colorText: AppColor.black,
                  onPressed: () {
                    Get.toNamed(Routes.REPORT_LIST_USER_PAGE,
                        arguments: [student.id, arguments[1]]);
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
