import 'package:flutter_talentaku/presentation/global_component/back_appbar.dart';
import 'package:flutter_talentaku/presentation/profile_page/component/profile_data_container.dart';
import 'package:flutter/material.dart';

import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:get/get.dart';

import '../daily_report/daily_report.screen.dart';
import '../global_component/icon_button_template.dart';
import 'component/profile_data_list.dart';
import 'component/profile_picture.dart';
import 'model/user_model.dart';

class ProfilePageScreen extends StatelessWidget {
  const ProfilePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserModel user = mockUserList[0];

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
              // USERNAME
              Text(user.name, style: AppTextStyle.tsTitle),
              Text(user.role,
                  style: AppTextStyle.tsNormal.copyWith(color: AppColor.blue600)),
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
                      dataUser: "123456",
                    ),
                    ProfileDataContainer(
                      title: "Kelompok",
                      icon: Icons.portrait_rounded,
                      dataUser: "Gajah",
                    ),
                  ],
                ),
              ),
              defaultHeightSpace,
              //LIST INFORMATION USER
              ProfileList(
                Title: "Nama Lengkap",
                Description: user.name,
              ),
              ProfileList(
                Title: "Tampat,Tanggal Lahir",
                Description: user.birthDate,
              ),
              ProfileList(
                Title: "Alamat",
                Description: user.address,
              ),
              ProfileList(
                Title: "Mulai di RBA",
                Description: "1 Januari 2024 ",
              ),             
              defaultHeightSpace,
              // LAPORAN PEMBELAJRAN
              IconButtonTemplate(
                text: "Laporan Pembelajaran", 
                icon: Icons.arrow_forward, 
                colorButton: AppColor.white,
                onPressed: () {
                  Get.to(DailyReportScreen());
                }
              ),
              defaultHeightSpace,
              // LOGOUT
              IconButtonTemplate(
                text: "Logout", 
                colorButton: AppColor.red,
                onPressed: () {
                  Get.off(ProfilePageScreen());
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
