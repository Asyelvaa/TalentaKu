import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/album_form_page/component/upload_option_bottomsheet.dart';
import 'package:flutter_talentaku/presentation/global_component/icon_button_template.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../infrastructure/theme/theme.dart';
import '../global_component/back_appbar.dart';
import 'controllers/album_form.controller.dart';

class AlbumFormScreen extends GetView<AlbumFormController> {
  const AlbumFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String gradeId = Get.arguments as String;

    return Scaffold(
        backgroundColor: AppColor.background,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: BackAppbar(titleAppbar: 'Unggah Foto / Video',)
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // SELECTED MEDIA
                Obx(() {
                  if (controller.selectedMedia.isEmpty) {
                    return Text(
                      'Belum ada foto / video yang dipilih',
                      style: AppTextStyle.tsNormal
                    );
                  } else {
                    return Column(
                      children: [
                        Container(
                          color: AppColor.grey,
                          height: heightScreen * 0.4,
                          child: ListView.builder(
                            controller: controller.pageController,
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.selectedMedia.length,
                            itemBuilder: (context, index) {
                              final file = controller.selectedMedia[index];
                              return Padding( 
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: file.path.endsWith('.mp4')
                                    ? AspectRatio(
                                        aspectRatio: 1.0, // Adjust aspect ratio for videos
                                        child: Icon(Icons.video_library),
                                      )
                                    : Image.file(
                                        file,
                                        fit: BoxFit.contain,
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
                            Text(
                              '${controller.currentPage.value + 1}/${controller.selectedMedia.length}',
                              style: AppTextStyle.tsNormal,
                            ),
                            IconButton(
                              onPressed: controller.nextPage,
                              icon: Icon(Icons.arrow_forward),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                }),
                defaultHeightSpace,
                // BUTTON PILIH FOTO
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton.icon(
                    onPressed: () => Get.bottomSheet(ShowUploadOptionsBottomSheet()),
                    icon: Icon(Icons.add, color: AppColor.black),
                    label: Text(
                      'Unggah Foto / Video Baru',
                      style: AppTextStyle.tsLittle.copyWith(fontWeight: FontWeight.bold)
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12,),
                // DESKRIPSI
                TextFormField(
                  controller: controller.descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Tambahkan deskripsi...',
                    hintStyle: AppTextStyle.tsLittle,
                    fillColor: AppColor.white,
                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: AppColor.blue500),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: AppColor.blue500),
                    ),
                  ),
                  maxLines: null,
                  minLines: 1,
                ),
                SizedBox(height: 12,),
                // BUTTON UPLOAD
                ElevatedButton(
                  onPressed: () {
                    controller.uploadAlbumPost(gradeId);
                  }, 
                  child: Center(
                    child: Text(
                      'Unggah',
                      style: AppTextStyle.tsLittle,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size.fromHeight(50),
                    backgroundColor: AppColor.blue100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
