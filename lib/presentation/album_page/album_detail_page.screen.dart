import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/common_widget/back_appbar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:image_downloader/image_downloader.dart';
import '../../domain/models/album_model.dart';
import '../common_widget/custom_popup_dialog.dart';
import 'component/post_card.dart';
import 'controllers/style_album.controller.dart';
import 'model/post_card_model.dart';

class AlbumDetailPage extends StatelessWidget {
  const AlbumDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RefreshController refreshController =
        RefreshController(initialRefresh: false);
    final controller = Get.put(AlbumController());
    final album = controller.album;

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: BackAppbar(
            titleAppbar: ' ',
          )),
      body: SmartRefresher(
        controller: refreshController,
        onRefresh: () async {
          await controller.pageController;

          refreshController.refreshCompleted();
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: heightScreen * 0.4,
                child: PageView.builder(
                  controller: controller.pageController,
                  itemCount: album.media?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    var media = album.media![index];
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(media.filePath!),
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: controller.previousPage,
                    icon: Icon(Icons.arrow_back),
                  ),
                  Obx(() => Text(
                        '${controller.currentPage.value + 1}/${album.media!.length}',
                        style: AppTextStyle.tsSmallRegular(AppColor.black),
                      )),
                  IconButton(
                    onPressed: controller.nextPage,
                    icon: Icon(Icons.arrow_forward),
                  ),
                ],
              ),
              spaceHeightExtraSmall,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(album.date!)}',
                    style: AppTextStyle.tsSmallBold(AppColor.black),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.save_alt),
                        // onPressed: () => controller.saveAllMedia(),
                        onPressed: () {
                          showCustomPopupDialog(
                            'Konfirmasi',
                            'Apakah Anda yakin ingin mengunduh semua foto?',
                            [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: AppColor.white),
                                onPressed: () => Get.back(),
                                child: Text(
                                  'Tidak',
                                  style: AppTextStyle.tsBodyRegular(
                                      AppColor.black),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor: AppColor.blue600),
                                onPressed: () {
                                  Get.back();
                                  controller.saveAllMedia();
                                },
                                child: Text(
                                  'Unduh Foto',
                                  style: AppTextStyle.tsBodyRegular(
                                      AppColor.white),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      if (controller.userRole
                          .any((role) => role.contains('Guru')))
                        IconButton(
                          icon: Icon(Icons.delete_forever, color: AppColor.red),
                          // onPressed: () => controller.saveAllMedia(),
                          onPressed: () {
                            showCustomPopupDialog(
                              'Konfirmasi',
                              'Apakah Anda yakin ingin menghapus semua foto?',
                              [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: AppColor.white),
                                  onPressed: () => Get.back(),
                                  child: Text(
                                    'Tidak',
                                    style: AppTextStyle.tsBodyRegular(
                                        AppColor.black),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      backgroundColor: AppColor.blue600),
                                  onPressed: () {
                                    Get.back();
                                    controller.delete();
                                  },
                                  child: Text(
                                    'Hapus Foto',
                                    style: AppTextStyle.tsBodyRegular(
                                        AppColor.white),
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                    ],
                  )
                ],
              ),
              spaceHeightExtraSmall,
              Container(
                width: widthScreen,
                decoration: BoxDecoration(
                    borderRadius: defaultBorderRadius, color: AppColor.blue50),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    album.desc?.join('\n') ?? '',
                    style: AppTextStyle.tsBodyRegular(AppColor.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
