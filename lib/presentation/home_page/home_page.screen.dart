import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/home/controllers/home.controller.dart';
import 'package:flutter_talentaku/presentation/home_page/Component/content.dart';
import 'package:flutter_talentaku/presentation/home_page/Component/header_content.dart';
import 'package:flutter_talentaku/presentation/home_page/Component/information.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Component/appbar.dart';

class HomePageScreen extends GetView<HomeController> {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: BaseAppBar(appBar: Appbar(), backgroundColor: Brand.background),
      backgroundColor: AppColor.background,
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              appbar(),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Container(
                    width: 340,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColor.white,
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20, top: 20),
                              child: Text("Informasi"),
                            ),
                            Container(
                              width: 110,
                              height: 25,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColor.blue300,
                              ),
                              margin: EdgeInsets.only(left: 75, top: 20),
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Text("Senin, 04/04/2024",
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                    )),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Container(
                            width: 320,
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 2,
                              itemBuilder: (context, index) {
                                return information(
                                  title: "Laporan Harian",
                                  date: "02 Februari 2024",
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              HeaderContent(
                  text: "Program",
                  imagePath: "assets/images/tambahan_image.png"),
              Container(
                width: Get.width,
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return HomeContent(
                      title: "Terapi Wicara",
                      txtButton: "Check it",
                      onTap: () {},
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              HeaderContent(
                  text: "Ekstrakulikuler",
                  imagePath: "assets/images/tambahan2_images.png"),
              Container(
                width: Get.width,
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return HomeContent(
                      title: "Terapi Wicara",
                      txtButton: "Check it",
                      onTap: () {},
                    );
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(20),
                          height: 210,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border:
                                  Border.all(color: AppColor.blue500, width: 1),
                              color: AppColor.white),
                          child: Text("Visi & \nMisi",
                              textAlign: TextAlign.start,
                              style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 18,
                                  color: Colors.black)),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColor.blue700),
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Text("KB & SD \nSekolah Inklusi Talenta",
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.white)),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: 150,
                            height: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColor.blue700),
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Text("Rumah Belajar Anak",
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.manrope(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              HeaderContent(
                  text: "Kurikulum",
                  imagePath: "assets/images/tambahan3_images.png"),
              HeaderContent(
                  text: "Kontak&Alamat",
                  imagePath: "assets/images/tambahan2_images.png"),
              Container(
                width: Get.width,
                height: 100,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return HomeContent(
                      title: "Terapi Wicara",
                      txtButton: "Check it",
                      onTap: () {},
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
