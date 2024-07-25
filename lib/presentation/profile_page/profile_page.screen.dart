import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../domain/models/user_model.dart';
import '../../infrastructure/theme/theme.dart';
import '../../infrastructure/navigation/routes.dart';
import '../global_component/default_appbar.dart';
import '../global_component/icon_button_template.dart';
import '../student_report_page/daily_report.screen.dart';
import 'controllers/profile_page.controller.dart';
import 'component/profile_data_container.dart';
import 'component/profile_data_list.dart';
import 'component/profile_picture.dart';

class ProfilePageScreen extends GetView<ProfilePageController> {
  const ProfilePageScreen({super.key});

  @override
  Widget build(BuildContext context) {

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
      // body: Obx(() {
      //   if (controller.isLoading.value) {
      //     return Center(child: CircularProgressIndicator());
      //   } else if (controller.userData.value != null) {
      //     var user = controller.userData.value!;
      //     return Padding(
      //       padding: EdgeInsets.all(16.0),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text('Name: ${user['name']}', style: TextStyle(fontSize: 18)),
      //           // Text('Email: ${user.email}', style: TextStyle(fontSize: 18)),
      //           // Text('Identification Number: ${user.identificationNumber}', style: TextStyle(fontSize: 18)),
      //           // Text('Address: ${user.address}', style: TextStyle(fontSize: 18)),
      //           // Text('Bir\th Date: ${user.birthInformation}', style: TextStyle(fontSize: 18)),
      //           // Text('Roles: ${user.roles.join(', ')}', style: TextStyle(fontSize: 18)),
      //           // user.photo != null
      //           //     ? Image.network(user.photo!)
      //           //     : Container(),
      //           // SizedBox(height: 20),
      //           // Text('Grades:', style: TextStyle(fontSize: 18)),
      //           // Expanded(
      //           //   child: ListView.builder(
      //           //     itemCount: user.grades.length,
      //           //     itemBuilder: (context, index) {
      //           //       return ListTile(
      //           //         title: Text(user.grades[index].toString()),
      //           //       );
      //           //     },
      //           //   ),
      //           // ),
      //         ],
      //       ),
      //     );
      //   } else {
      //     return Center(child: Text('No user data found.'));
      //   }
      // })

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: ProfilePicture(),
              ),
              SizedBox( height: 12,),
              Obx(() {
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
                      Text(controller.username, style: AppTextStyle.tsTitle),
                      Text(controller.roles.join(', '), style: AppTextStyle.tsNormal.copyWith(color: AppColor.blue600)),
                      // Text(controller.currentUser.value!.name, style: AppTextStyle.tsTitle),
                      // Text(controller.currentUser.value!.roles.join(', '), style: AppTextStyle.tsNormal.copyWith(color: AppColor.blue600)),
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
                      // icon: Icons.library_books_outlined,
                      // dataUser: controller.currentUser.value!.identificationNumber ?? '-',
                      dataUser: controller.userData['identification_number'],
                    ),
                    ProfileDataContainer(
                      title: "Kelompok",
                      // icon: Icons.portrait_rounded,
                      dataUser: '-',
                      // dataUser: controller.user.join(", "),
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
                          // Description: controller.currentUser.value!.name,
                        ),
                        ProfileList(
                          Title: "Tampat, Tanggal Lahir",
                          Description: controller.userData['birth_information'],
                          // Description: controller.currentUser.value!.birthInformation,

                        ),
                        ProfileList(
                          Title: "Alamat",
                          Description: controller.userData['address'],
                          // Description: controller.currentUser.value!.address,

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
                colorButton: AppColor.blue600,
                onPressed: () {
                  Get.toNamed(Routes.DAILY_REPORT);
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
