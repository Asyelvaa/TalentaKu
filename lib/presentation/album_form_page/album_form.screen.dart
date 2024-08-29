import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/album_form_page/component/upload_option_bottomsheet.dart';
import 'package:flutter_talentaku/presentation/common_widget/custom_button_icon.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';
import '../common_widget/back_appbar.dart';
import '../common_widget/custom_textFormField.dart';
import 'controllers/album_form.controller.dart';

class AlbumFormScreen extends StatelessWidget {
  const AlbumFormScreen({Key? key}) : super(key: key);

  Future<void> _confirmRemoveMedia(int index) async {
    final controller = Get.find<AlbumFormController>();
    final result = await Get.dialog<bool>(
      AlertDialog(
        title: Text('Hapus Media'),
        content: Text('Anda yakin ingin menghapus ini?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text('Batal'),
          ),
          TextButton(
            onPressed: () => Get.back(result: true),
            child: Text('Hapus'),
          ),
        ],
      ),
    );

    if (result == true) {
      controller.selectedMedia.removeAt(index);
      controller.update();
    }
  }

  @override
  Widget build(BuildContext context) {
     final arguments = Get.arguments as Map<String, dynamic>;
    final gradeId = arguments['gradeId'] as String;
    final controller = Get.put(AlbumFormController());

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
                    return Container(
                      height: heightScreen * 0.4,
                      width: widthScreen,
                      color: AppColor.grey,
                      child: Center(
                        child: Text(
                          'Belum ada foto / video yang dipilih',
                          style: AppTextStyle.tsNormal
                        ),
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        Container(
                          height: heightScreen * 0.4,
                          width: widthScreen ,
                          child: PageView.builder(
                            controller: controller.pageController,
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.selectedMedia.length,
                            itemBuilder: (context, index) {
                              final file = controller.selectedMedia[index];
                              return Stack(
                                children: [
                                  Container(
                                    height: heightScreen * 0.4,
                                    width: widthScreen, 
                                    color: AppColor.grey,
                                    child : file.path.endsWith('.mp4')
                                      ? AspectRatio(
                                          aspectRatio: 1.0, 
                                          child: Icon(Icons.video_library),
                                        )
                                      : Image.file(
                                          file,
                                          fit: BoxFit.scaleDown,
                                        )
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: IconButton(
                                      icon: Icon(Icons.cancel, color: AppColor.black, size: 24,),
                                      onPressed: () => _confirmRemoveMedia(index),
                                    ),
                                  ),
                                ],
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
                    // onPressed: () => Get.bottomSheet(ShowUploadOptionsBottomSheet()),
                    onPressed: () {
                      controller.pickMedia();
                    },
                    icon: Icon(Icons.add, color: AppColor.black),
                    label: Text(
                      'Unggah Foto Baru',
                      style: AppTextStyle.tsBodyRegular(AppColor.black)
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
                CustomTextFormField(
                  loginController: controller.descriptionController, 
                  labelText:  'Tambahkan deskripsi...',
                ),                
                SizedBox(height: 12,),
                // BUTTON UPLOAD
                ElevatedButton(
                  onPressed: () async {
                    await controller.uploadAlbumPost(gradeId);                    
                  },
                  child: Obx(() {
                    return controller.isLoading.value
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text(
                            'Unggah',
                            style: AppTextStyle.tsBodyBold(AppColor.white),
                          );
                  }),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(widthScreen, 50), 
                    backgroundColor: AppColor.blue600,
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
