import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/home_page/Component/SlideExtra.dart';
import 'package:flutter_talentaku/presentation/home_page/Component/slide_information.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';
import '../common_widget/default_appbar.dart';
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
              // if (controller.userRole
              //     .any((role) => role == 'Murid KB' || role == 'Murid SD'))
              //   ClassInformation(
              //     titleInfo: "Laporan harian Dimas",
              //     dateInfo: '04 April 2024',
              //   ),
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
                      headerContent: "Program Tambahan",
                      image: "program_tambahan.png",
                      contentTitles: controller.contentTitles,
                    )),
              Obx(() => controller.isLoading.value
                  ? SlideExtra(
                      headerContent: "Loading.... ",
                      image: "program_tambahan.png",
                      contenExtra: [
                        'Loading...',
                        'Loading...',
                        'Loading...',
                        'Loading...',
                        'Loading...'
                      ],
                    )
                  : SlideExtra(
                      headerContent: "Extrakurikuler ",
                      image: "program_tambahan.png",
                      contenExtra: controller.contenExtra,
                    )),
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
                        Container(height: heightScreen * 0.12, child: KbSdTalentaComponent()),
                        SizedBox(
                          height: 10,
                        ),
                        Container(height: heightScreen * 0.12, child: RbaTalentaComponent()),
                      ],
                    ),
                  ],
                ),
              ),
              // SlideContact(
              //   headerContent: "Kurikulum",
              //   image: "ekstrakurikuler.png",
              //   contentTitles: ['Title 1', 'Title 2', 'Title 3', 'Title 4'],
              //   contentDesc: ['desc1', 'desc2', 'desc3', 'desc4'],
              // ),
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
