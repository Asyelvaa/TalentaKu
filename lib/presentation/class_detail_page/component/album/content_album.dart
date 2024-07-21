import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_talentaku/domain/models/album_model.dart';
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
            onTap: () => Get.toNamed(Routes.ALBUM_FORM_PAGE,),
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
        Obx((){
          if (controller.isLoading.value) {
            return SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (controller.albums.isEmpty) {
            return SliverToBoxAdapter(
              child: Center(child: Text('No albums found')),
            );
          } else {
            var media = <Media>[];
            for (var album in controller.albums) {
              media.addAll(album.media);
            }
            media.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            return SliverGrid(
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
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:  NetworkImage(media[index].filePath),
                        // image: FileImage(File(media[index].filePath)),
                        fit: BoxFit.cover,
                      ),
                    )
                  ),
                );
              },
              childCount: media.length, 
            ),
          );
          }
        })
      ],
    );
  }
}