import 'package:flutter_talentaku/presentation/profile_page/component/profile_data_container.dart';
import 'package:flutter/material.dart';

import 'package:flutter_talentaku/infrastructure/theme/theme.dart';

import '../global_component/text_container.dart';
import 'component/profile_data_list.dart';
import 'component/profile_picture.dart';

class ProfilePageScreen extends StatelessWidget {
  const ProfilePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
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
              Text("Sekar", style: AppTextStyle.tsTitle),
              Text("Siswi KB",
                  style: AppTextStyle.tsLittle.copyWith(color: Colors.grey)),
              SizedBox(
                height: 30,
              ),
              // NIS & KELOMPOK
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfileDataContainer(
                    title: "NIS",
                    icon: Icons.abc,
                    dataUser: "123456",
                  ),
                  SizedBox( 
                    width: 20,
                  ),
                  ProfileDataContainer(
                    title: "Kelompok",
                    icon: Icons.abc,
                    dataUser: "Gajah",
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              //LIST INFORMATION USER
              ProfileList(
                Title: "Nama Lengkap",
                Description: "Sekar Annisa",
              ),
              ProfileList(
                Title: "Tampat,Tanggal Lahir",
                Description: "Batang, 17 Maret 2000",
              ),
              ProfileList(
                Title: "Alamat",
                Description: "Kuman rt 9 rw 1, kec. Batang, kab. Batang",
              ),
              ProfileList(
                Title: "Mulai di RBA",
                Description: "1 Januari 2024 ",
              ),             
              SizedBox(
                height: 10,
              ),
              // LAPORAN PEMBELAJRAN
              TextWithContainer(
                colorContainer: AppColor.blue200, 
                text: "Laporan Pembelajaran",
                icon: Icons.arrow_forward,
              ),
              SizedBox(height: 20),
              // LOGOUT
              TextWithContainer(
                colorContainer: AppColor.red, 
                text: "Logout",
                colorText: AppColor.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}






