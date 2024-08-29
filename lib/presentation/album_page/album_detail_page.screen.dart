import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/common_widget/back_appbar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
// import 'package:image_downloader/image_downloader.dart';
import '../../domain/models/album_model.dart';
import 'component/post_card.dart';
import 'controllers/style_album.controller.dart';
import 'model/post_card_model.dart';

class AlbumDetailPage extends StatelessWidget {
  const AlbumDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final RefreshController refreshController =
        RefreshController(initialRefresh: false);
    final Album album = Get.arguments as Album;
    final controller = Get.put(AlbumController());

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
              Obx(
                () => Container(
                  height: heightScreen * 0.4,
                  child: PageView.builder(
                    controller: controller.pageController,
                    itemCount: album.media?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      var media = album.media![index];

                      return media.filePath != null
                          ? Shimmer(
                              duration: Duration(seconds: 2),
                              color: Colors.grey.shade300,
                              enabled: true,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            )
                          : Container(
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
                    '${album.date ?? 'N/A'}',
                    style: AppTextStyle.tsSmallBold(AppColor.black),
                  ),
                  IconButton(
                    icon: Icon(Icons.save_alt),
                    onPressed: () => controller.saveAllMedia(),
                  ),
                ],
              ),
              spaceHeightExtraSmall,
              Container(
                width: widthScreen,
                decoration: BoxDecoration(
                  borderRadius: defaultBorderRadius,
                  color: AppColor.black.withOpacity(0.1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    album.desc?.join(', ') ?? '',
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
