import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/common_widget/default_appbar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'Component/SlideExtra.dart';
import 'Component/class_information.dart';
import 'Component/slide_program.dart';
import 'Component/home_visimisi_information.dart';
import 'Component/home_kbsd_information.dart';
import 'Component/home_rba_information.dart';
import 'Component/slide_information.dart';
import 'controllers/home_page.controller.dart';

class HomePageScreen extends GetView<HomePageController> {
  const HomePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RefreshController refreshController =
        RefreshController(initialRefresh: false);

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultAppbar(),
      ),
      body: SmartRefresher(
        controller: refreshController,
        onRefresh: () async {
          await controller.fetchContactAndInformation();
          await controller.fetchExtra();
          await controller.fetchProgram();
          await controller.fetchInformationList();

          refreshController.refreshCompleted();
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (controller.userRole
                    .any((role) => role == 'Murid KB' || role == 'Murid SD'))
                  ClassInformation(
                    titleInfo: "Informasi",
                    dateInfo:
                        DateFormat('dd MMMM yyyy', 'id').format(DateTime.now()),
                  ),
                Obx(() => controller.isLoading.value
                    ? Shimmer(
                        duration: Duration(seconds: 2),
                        color: Colors.grey.shade300,
                        enabled: true,
                        child: SlideInformation(
                          headerContent: "Loading.... ",
                          image: "program_tambahan.png",
                          contentTitles: [
                            'Loading...',
                            'Loading...',
                            'Loading...',
                            'Loading...',
                            'Loading...',
                            'Loading...',
                          ],
                        ),
                      )
                    : SlideInformation(
                        headerContent: "Program Tambahan",
                        image: "program_tambahan.png",
                        contentTitles: controller.contentTitles,
                      )),
                Obx(() => controller.isLoading.value
                    ? Shimmer(
                        duration: Duration(seconds: 2),
                        color: Colors.grey.shade300,
                        enabled: true,
                        child: SlideExtra(
                          headerContent: "Loading.... ",
                          image: "program_tambahan.png",
                          contenExtra: [
                            'Loading...',
                            'Loading...',
                            'Loading...',
                            'Loading...',
                          ],
                        ),
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
                          Container(height: 100, child: KbSdTalentaComponent()),
                          SizedBox(
                            height: 10,
                          ),
                          Container(height: 100, child: RbaTalentaComponent()),
                        ],
                      ),
                    ],
                  ),
                ),
                Obx(() => controller.isLoading.value
                    ? Shimmer(
                        duration: Duration(seconds: 2),
                        color: Colors.grey.shade300,
                        enabled: true,
                        child: SlideContact(
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
                        ),
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
      ),
    );
  }
}
