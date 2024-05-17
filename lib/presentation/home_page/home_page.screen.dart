import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/home_page/Component/slide_information.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';
import 'Component/header_content.dart';
import 'Component/class_information.dart';
import 'controllers/home_page.controller.dart';

class HomePageScreen extends GetView<HomePageController> {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClassInformation(
                titleInfo: "Laporan harian Erina", 
                dateInfo: '04 April 2024'
              ),
              SlideInformation(
                headerContent: "Program", 
                image: "assets/images/tambahan_image.png",
                contentTitles: ['Title 1', 'Title 2', 'Title 3', 'Title 4'],
              ),
              SlideInformation(
                headerContent: "Ekstrakulikuler", 
                image: "assets/images/tambahan2_image.png",
                contentTitles: ['Title 1', 'Title 2', 'Title 3', 'Title 4'],
              ),
              Container(
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
                            border: Border.all(
                                color: AppColor.blue500, width: 1),
                            color: AppColor.white),
                        child: Text("Visi & \nMisi",
                            textAlign: TextAlign.start,
                            style: AppTextStyle.tsTitle),
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
                                style: AppTextStyle.tsNormal),
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
                                style: AppTextStyle.tsNormal),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SlideInformation(
                headerContent: "Kurikulum", 
                image: "assets/images/tambahan3_image.png",
                contentTitles: ['Title 1', 'Title 2', 'Title 3', 'Title 4'],
              ),
              SlideInformation(
                headerContent: "Kontak&Alamat", 
                image: "assets/images/tambahan2_images.png",
                contentTitles: ['Title 1', 'Title 2', 'Title 3', 'Title 4'],
              ),
              HeaderContent(
                  text: "Kontak&Alamat",
                  imagePath: "assets/images/tambahan2_images.png"),
            ],
          ),
        ),
      ),
    );
  }
}

