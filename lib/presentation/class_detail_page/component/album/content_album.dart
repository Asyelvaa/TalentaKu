
import 'package:flutter/material.dart';
import 'package:flutter_talentaku/domain/models/album_model.dart';
import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/album_form_page/album_form.screen.dart';
import 'package:flutter_talentaku/presentation/album_page/album_detail_page.screen.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/controllers/class_detail.controller.dart';
import 'package:get/get.dart';

class ContentAlbum extends GetView<ClassDetailController> {
  const ContentAlbum({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: CustomScrollView(
        slivers: [
          // Obx(() {
          //     var roles = controller.userRole;
          //     if (controller.isLoading.value) {
          //       return SliverToBoxAdapter(
          //         child: Center(child: CircularProgressIndicator()),
          //       );
          //     } 
          //     else if (roles != null && roles.any((role) => role.contains('Guru'))) {
          //       return SliverToBoxAdapter(
          //         child: GestureDetector(
          //           onTap: () => Get.to(
          //             () => AlbumFormScreen(), 
          //             arguments: {'gradeId' : controller.classItem['id'].toString()}
          //           ),
          //           child: Padding(
          //             padding: const EdgeInsets.only(bottom: 8.0),
          //             child: Container(
          //               alignment: Alignment.center,
          //               height: 40,
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(12),
          //                 color: AppColor.blue100,
          //               ),
          //               child: Text('Upload Photo / Video',
          //                   style: AppTextStyle.tsSmallBold(AppColor.black)),
          //             ),
          //           ),
          //         ),
          //       );
          //     } else {
          //       return SliverToBoxAdapter(child: Container());
          //     }
          //   }),
          Obx((){
            if (controller.isLoading.value) {
              return SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (controller.albums.isEmpty) {
              return SliverToBoxAdapter(
                child: Center(child: Container(
                  padding: EdgeInsets.all(20),
                  child: Text('Belum ada foto yang diunggah', style: AppTextStyle.tsBodyRegular(AppColor.black),),),)
              );
            } else {
              return SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    var album = controller.albums[index];

                    return GestureDetector(
                      onTap: () => Get.to(AlbumDetailPage(), arguments: album),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(album.media![0].filePath!),
                            fit: BoxFit.cover,
                            
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: controller.albums.length,
                ),
              );            }
          })
        ],
      ),
    );
  }
}