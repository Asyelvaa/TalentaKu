import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:iconsax/iconsax.dart';

import 'component/ProfileList.dart';

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
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.red,
                      backgroundImage: AssetImage('assets/images/profilw.png'),
                    ),
                    Positioned(
                      bottom: 15,
                      right: 5,
                      child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.blue600,
                            border: Border.all(color: Colors.white, width: 1)),
                        child: Icon(
                          Iconsax.edit_25,
                          color: AppColor.white,
                        ),
                      ),
                    )
                  ],
                ),
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
                  Container(
                    height: 70,
                    width: 150,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: AppColor.blue400),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 5, left: 20),
                            child: Icon(Icons.abc)),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 20, right: 10),
                              child: Text(
                                "NIP",
                                style: GoogleFonts.manrope(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                    color: Colors.grey),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "52525",
                                  style: GoogleFonts.manrope(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 70,
                    width: 150,
                    decoration: BoxDecoration(
                        border: Border.all(width: 2, color: AppColor.blue400),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        Padding(
                            padding: EdgeInsets.only(top: 5, left: 20),
                            child: Icon(Icons.abc)),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 15, left: 10),
                              child: Text(
                                "Kelompok",
                                style: GoogleFonts.manrope(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12,
                                    color: Colors.grey),
                              ),
                            ),
                            Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Text(
                                  "Gajah",
                                  style: GoogleFonts.manrope(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ))
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              //LIST INFORMATION USER
              ProfileList(
                Title: "Nama Lengkap",
                Description: "Sekar binti AHmad ",
              ),
              SizedBox(
                height: 5,
              ),
              ProfileList(
                Title: "Tampat,Tanggal Lahir",
                Description: "Batang, 17 Maret 2000",
              ),
              SizedBox(
                height: 5,
              ),
              ProfileList(
                Title: "Alamat",
                Description: "Kuman rt 9 rw 1, kec. Batang, kab. Batang",
              ),
              SizedBox(
                height: 5,
              ),
              ProfileList(
                Title: "Mulai di RBA",
                Description: "1 Januari 2024 ",
              ),
              SizedBox(
                height: 10,
              ),

              // LAPORAN
              Container(
                width: Get.width,
                height: 60,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.blue200),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Laporan Pembelajaran",
                        style: GoogleFonts.manrope(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Icon(Icons.abc)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                width: Get.width,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.red,
                ),
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      "Logout",
                      style: GoogleFonts.manrope(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColor.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
