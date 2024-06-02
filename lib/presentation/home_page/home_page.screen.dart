import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';
import '../global_component/default_appbar.dart';
import 'Component/class_information.dart';
import 'Component/slide_information.dart';
import 'controllers/home_page.controller.dart';

class HomePageScreen extends GetView<HomePageController> {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultAppbar(),
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
                headerContent: "Program ", 
                image: "program_tambahan.png",
                contentTitles: ['Terapi wicara', 'Pijat stimulasi', 'English Special Club', 'Outing Class', 'Catering Sehat'],
              ),
              SlideInformation(
                headerContent: "Ekstrakulikuler", 
                image: "ekstrakurikuler.png",
                contentTitles: ['Musik & Tari', 'Kreasi & Gambar', 'Batik Eco Print', 'Cooking', 'Renang'],
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
                          width: widthScreen * 0.5,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColor.blue700),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text("KB & SD \nInklusi Talenta",
                                textAlign: TextAlign.start,
                                style: AppTextStyle.tsNormal.copyWith(color: AppColor.white)),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: widthScreen * 0.5,
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColor.blue700),
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text("Rumah Belajar Anak",
                                textAlign: TextAlign.start,
                                style: AppTextStyle.tsNormal.copyWith(color: AppColor.white)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SlideInformation(
                headerContent: "Kurikulum", 
                image: "ekstrakurikuler.png",
                contentTitles: ['Title 1', 'Title 2', 'Title 3', 'Title 4'],
              ),
              SlideInformation(
                headerContent: "Kontak&Alamat", 
                image: "ekstrakurikuler.png",
                contentTitles: ['Whatsapp', 'Email', 'Instagram', 'Alamat'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

