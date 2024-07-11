import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/home_page/Component/slide_information.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';
import '../global_component/default_appbar.dart';
import 'Component/class_information.dart';
import 'Component/home_kbsd_information.dart';
import 'Component/home_rba_information.dart';
import 'Component/slide_program.dart';
import 'Component/home_visimisi_information.dart';
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
              Obx(() => controller.isLoading.value
                  ? SlideInformation(
                      headerContent: "Loading.... ",
                      image: "program_tambahan.png",
                      contentTitles: [
                        'Loading...',
                        'Loading...',
                        'Loading...',
                        'Loading...',
                        'Loading...'
                      ],
                    )
                  : SlideInformation(
                      headerContent: "Programs ",
                      image: "program_tambahan.png",
                      contentTitles: controller.contentTitles.value,
                    )),
              SlideInformation(
                headerContent: "Ekstrakulikuler",
                image: "ekstrakurikuler.png",
                contentTitles: [
                  'Musik & Tari',
                  'Kreasi & Gambar',
                  'Batik Eco Print',
                  'Cooking',
                  'Renang'
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    VisiMisiComponent(),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(height:100, child: KbSdTalentaComponent()),
                        SizedBox(
                          height: 10,
                        ),
                        Container(height:100, child: RbaTalentaComponent()),
                      ],
                    ),
                  ],
                ),
              ),
              SlideContact(
                headerContent: "Kurikulum",
                image: "ekstrakurikuler.png",
                contentTitles: ['Title 1', 'Title 2', 'Title 3', 'Title 4'],
                contentDesc: ['desc1', 'desc2', 'desc3', 'desc4'],
              ),
              Obx(() => controller.isLoading.value
                  ? SlideContact(
                      headerContent: "Loading....",
                      image: "ekstrakurikuler.png",
                      contentTitles: [
                        'Loading...',
                        'Loading...',
                        'Loading...',
                        'Loading...',
                        'Loading...'
                      ],
                      contentDesc: [
                        'Loading...',
                        'Loading...',
                        'Loading...',
                        'Loading...',
                      ],
                    )
                  : SlideContact(
                      headerContent: "Kontak & Alamat",
                      image: "ekstrakurikuler.png",
                      contentTitles: controller.contact.value,
                      contentDesc: controller.desc.value,
                    )),
            ],
          ),
        ),
      ),
    );
  }
}
