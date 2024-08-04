import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/models/user_model.dart';
import '../../infrastructure/theme/theme.dart';
import '../../infrastructure/navigation/routes.dart';
import '../global_component/default_appbar.dart';
import '../global_component/icon_button_template.dart';
import 'controllers/profile_page.controller.dart';
import 'component/profile_data_container.dart';
import 'component/profile_data_list.dart';
import 'component/profile_picture.dart';

class ProfilePageScreen extends GetView<ProfilePageController> {
  const ProfilePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfilePageController controller = Get.put(ProfilePageController());

    Future<void> _showLogoutConfirmationDialog() async {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Konfirmasi Logout",
              style: AppTextStyle.tsTitle,
            ),
            content: Text(
              "Apakah Anda yakin ingin logout?",
              style: AppTextStyle.tsNormal,
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "Batal",
                  style: AppTextStyle.tsNormal,
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              TextButton(
                child: Text(
                  "Logout",
                  style: AppTextStyle.tsNormal,
                ),
                onPressed: () {
                  controller.logout();
                  Get.back();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultAppbar(),
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
                final UserModel user = controller.user.value;
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
                      Text(user.name, style: AppTextStyle.tsTitle),
                      Text(user.roles.join(", "),
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
                      dataUser: controller.user.value.identificationNumber,
                    ),
                    ProfileDataContainer(
                      title: "Kelompok",
                      icon: Icons.portrait_rounded,
                      dataUser: controller.user.value.grades.join(", "),
                    ),
                  ],
                ),
              ),
              defaultHeightSpace,
              //LIST INFORMATION USER
              Obx(() => controller.isLoading.value == true
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
              // defaultHeightSpace,
              // LAPORAN PEMBELAJARAN
              IconButtonTemplate(
                text: "Laporan Pembelajaran",
                icon: Icons.arrow_forward,
                colorButton: AppColor.blue600,
                onPressed: () {
                  Get.toNamed(Routes.REPORT_LIST_PAGE,
                      arguments: [controller.userData['id']]);
                },
              ),
              defaultHeightSpace,
              // LOGOUT
              IconButtonTemplate(
                text: "Logout",
                colorButton: AppColor.red,
                onPressed: () {
                  _showLogoutConfirmationDialog();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
