import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/profile_page/controllers/profile_page.controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../student_report_page/daily_report.screen.dart';
import '../global_component/back_appbar.dart';
import '../../infrastructure/theme/theme.dart';
import '../global_component/icon_button_template.dart';
import 'component/profile_data_container.dart';
import 'component/profile_data_list.dart';
import 'component/profile_picture.dart';
import 'model/user_model.dart';

class ProfilePageScreen extends StatelessWidget {
  const ProfilePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfilePageController controller = Get.put(ProfilePageController());

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: BackAppbar(titleAppbar: "My Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: ProfilePicture(),
              ),
              SizedBox(
                height: 10,
              ),
              Obx(() {
                final UserModel user =
                    Get.find<ProfilePageController>().user.value;
                if (controller.isLoading.value == true) {
                  return Column(
                    children: [
                      Text('Loading...', style: AppTextStyle.tsTitle),
                      Text('Loading...',
                          style: AppTextStyle.tsNormal
                              .copyWith(color: AppColor.blue600)),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      Text(controller.userData['name'],
                          style: AppTextStyle.tsTitle),
                      Text(controller.role[0],
                          style: AppTextStyle.tsNormal
                              .copyWith(color: AppColor.blue600)),
                    ],
                  );
                }
              }),
              defaultHeightSpace,
              // NIS & KELOMPOK
              Container(
                width: Get.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ProfileDataContainer(
                      title: "NIS",
                      icon: Icons.library_books_outlined,
                      dataUser: controller.user.value.nomorInduk,
                    ),
                    ProfileDataContainer(
                      title: "Kelompok",
                      icon: Icons.portrait_rounded,
                      dataUser: controller.user.value.grades,
                    ),
                  ],
                ),
              ),
              defaultHeightSpace,
              //LIST INFORMATION USER
              Obx(() => controller.isLoading.value
                  ? Column(
                      children: [
                        ProfileList(
                          Title: "Nama Lengkap",
                          Description: "Loading...",
                        ),
                        ProfileList(
                          Title: "Tampat, Tanggal Lahir",
                          Description: "Loading...",
                        ),
                        ProfileList(
                          Title: "Alamat",
                          Description: "Loading...",
                        ),
                        ProfileList(
                          Title: "Mulai di RBA",
                          Description: "Loading...",
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        ProfileList(
                          Title: "Nama Lengkap",
                          Description: controller.userData['name'],
                        ),
                        ProfileList(
                          Title: "Tampat, Tanggal Lahir",
                          Description: controller.userData['birth_information'],
                        ),
                        ProfileList(
                          Title: "Alamat",
                          Description: controller.userData['address'],
                        ),
                        ProfileList(
                          Title: "Mulai di RBA",
                          Description: '-',
                        ),
                      ],
                    )),
              defaultHeightSpace,
              // LAPORAN PEMBELAJARAN
              IconButtonTemplate(
                text: "Laporan Pembelajaran",
                icon: Icons.arrow_forward,
                colorButton: AppColor.white,
                onPressed: () {
                  Get.to(DailyReportScreen());
                },
              ),
              defaultHeightSpace,
              // LOGOUT
              IconButtonTemplate(
                text: "Logout",
                colorButton: AppColor.red,
                onPressed: () {
                  controller.logout();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
