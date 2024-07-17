import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/album_page/album_detail_page.screen.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/controllers/class_detail.controller.dart';
import 'package:get/get.dart';

class ContentAlbum extends GetView<ClassDetailController> {
  const ContentAlbum({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: GestureDetector(
            onTap: () => Get.toNamed(Routes.ALBUM_FORM_PAGE, arguments: controller.gradeId),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColor.blue100,
                ),
                child: Text(
                  'Upload Photo / Video',
                  style: AppTextStyle.tsLittle
                ),
              ),
            ),
          ),
        ),
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => Get.to(AlbumDetailPage()),
                child: Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: Text('image $index'),
                  ),
                ),
              );
            },
            childCount: 11, 
          ),
        ),
      ],
    );
  }
}