import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/profile_page/component/reset_password.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../domain/models/user_model.dart';
import '../../infrastructure/navigation/routes.dart';
import '../../infrastructure/theme/theme.dart';
import '../common_widget/custom_button.dart';
import '../common_widget/custom_popup_dialog.dart';
import '../common_widget/default_appbar.dart';
import '../common_widget/custom_button_icon.dart';
import 'controllers/profile_page.controller.dart';
import 'component/profile_data_list.dart';
import 'component/profile_picture.dart';

class ProfilePageScreen extends GetView<ProfilePageController> {
  const ProfilePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = controller.currentUser.value;
    final RefreshController refreshController =
        RefreshController(initialRefresh: false);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(heightScreen * 0.075),
        child: DefaultAppbar(),
      ),
      body: SmartRefresher(
        controller: refreshController,
        onRefresh: () async {
          await controller.currentUser;

          refreshController.refreshCompleted();
        },
        child: SingleChildScrollView(
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
                  print(user);
                  if (controller.isLoading.value == true) {
                    return Column(
                      children: [
                        Text('Loading...',
                            style: AppTextStyle.tsBodyRegular(AppColor.black)),
                        Text('Loading...',
                            style: AppTextStyle.tsBodyRegular(AppColor.black)),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Text(user.name ?? 'name',
                            style: AppTextStyle.tsTitleBold(AppColor.black)),
                        Text(user.roles!.join(', '),
                            style: AppTextStyle.tsBodyBold(AppColor.blue500)),
                      ],
                    );
                  }
                }),
                spaceHeightNormal,

                // LIST INFORMATION USER
                Obx(() {
                  if (controller.isLoading.value)
                    return Column(
                      children: [
                        ProfileList(
                          Title: "Nama Lengkap",
                          Description: "Loading...",
                        ),
                        ProfileList(
                          Title: "NIS",
                          Description: "Loading...",
                        ),
                        ProfileList(
                          Title: "Tempat, Tanggal Lahir",
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
                    );
                  else
                    return Column(
                      children: [
                        ProfileList(
                          Title: "Nama Lengkap",
                          Description: user.name ?? '-',
                        ),
                        ProfileList(
                          Title: "NIS",
                          Description: user.nomorInduk ?? '-',
                        ),
                        ProfileList(
                          Title: "Tempat, Tanggal Lahir",
                          Description: user.birthInformation ?? '-',
                        ),
                        ProfileList(
                          Title: "Alamat",
                          Description: user.address ?? '-',
                        ),
                        ProfileList(
                          Title: "Mulai di RBA",
                          Description: '-',
                        ),
                      ],
                    );
                }),
                spaceHeightNormal,

                CustomButton(
                  text: "Reset Password",
                  colorButton: AppColor.red,
                  colorText: AppColor.white,
                  onPressed: () {
                    Get.to(
                      UpdatePassword(),
                    );
                  },
                ),
                spaceHeightNormal,
                // LOGOUT
                CustomButton(
                  text: "Logout",
                  colorButton: AppColor.red,
                  colorText: AppColor.white,
                  onPressed: () {
                    showCustomPopupDialog(
                      "Keluar Akun",
                      "Apakah Anda yakin ingin keluar akun?",
                      [
                        ElevatedButton(
                          onPressed: () => Get.back(),
                          child: Text(
                            "Tidak",
                            style: AppTextStyle.tsBodyRegular(AppColor.black),
                          ),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(AppColor.blue500)),
                          onPressed: () => controller.logout(),
                          child: Text(
                            "Iya, Keluar",
                            style: AppTextStyle.tsBodyRegular(AppColor.white),
                          ),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
