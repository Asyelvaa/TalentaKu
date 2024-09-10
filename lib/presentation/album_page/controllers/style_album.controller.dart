import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:image_downloader/image_downloader.dart';
// import 'package:image_downloader/image_downloader.dart';

import '../../../domain/models/album_model.dart';
import '../../../infrastructure/dal/services/api_album.dart';
import '../../../infrastructure/theme/theme.dart';
import '../../class_detail_page/controllers/class_detail.controller.dart';

class AlbumController extends GetxController {
  late List<String> userRole;
  late PageController pageController;
  late final Album album;
  late final String gradeId;
  final RxInt currentPage = 0.obs;
  late List<Media> mediaList;
  var isLoading = false.obs;

  @override
  void onInit() {
    userRole = GetStorage().read('dataUser')['role'];
     final arguments = Get.arguments as Map<String, dynamic>;
    album = arguments['album'];
    gradeId = arguments['gradeId'];
    // album = Get.arguments as Album;
    mediaList = album.media ?? [];

    pageController = PageController()
      ..addListener(() {
        currentPage.value = pageController.page!.round();
      });
      
    super.onInit();
  }

  void nextPage() {
    if (pageController.hasClients && currentPage.value < mediaList.length - 1) {
      currentPage.value++;
      pageController.animateToPage(
        currentPage.value,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousPage() {
    if (pageController.hasClients && currentPage.value > 0) {
      currentPage.value--;
      pageController.animateToPage(
        currentPage.value,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> saveAllMedia() async {
    try {
      for (var media in mediaList) {
        // Periksa apakah filePath adalah URL penuh atau hanya path relatif
        final isFullUrl = media.filePath!.startsWith('http');
        final url = isFullUrl
            ? media.filePath!
            : 'https://talentaku.site/image/album-media/${media.filePath!}';

        print('Requesting URL: $url'); // Log URL yang akan digunakan

        try {
          var response = await Dio().get(
            url,
            options: Options(responseType: ResponseType.bytes),
          );

          if (response.statusCode == 200) {
            await ImageGallerySaver.saveImage(
              Uint8List.fromList(response.data),
              quality: 60,
              name: "downloaded_image",
            );
          } else {
            Get.snackbar(
              'Error',
              'Failed to download media: ${media.filePath}, Status code: ${response.statusCode}',
            );
          }
        } catch (e) {
          if (e is DioException && e.response?.statusCode == 404) {
            Get.snackbar(
              'Error',
              'Media not found: ${media.filePath}',
            );
          } else {
            Get.snackbar(
              'Error',
              'Failed to download media: ${media.filePath}',
            );
          }
          print(e);
        }
      }
      Get.snackbar('Success', 'All media processed');
    } catch (e) {
      Get.snackbar('Error', 'Failed to save all media');
      print(e);
    }
  }

  Future<void> delete() async {
    final albumId = album.id.toString();
    try {
      isLoading.value = true;
      await ApiServiceAlbum().deleteAlbum(gradeId, albumId);
      // final classDetailController = Get.find<ClassDetailController>();
      // await classDetailController.fetchAlbums();
      // Safely access ClassDetailController after ensuring it's registered and available
      // if (Get.isRegistered<ClassDetailController>()) {
      //   final classDetailController = Get.find<ClassDetailController>();
        
      //   // Schedule the fetchAlbums call to run after the current frame completes
      //   WidgetsBinding.instance.addPostFrameCallback((_) async {
      //     await classDetailController.fetchAlbums();
      //   });
      // }
      Get.back();
      dialogSuccess('Foto Berhasil dihapus');
    } catch (e) {
      dialogError('Gagal menghapus foto');
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void dialogSuccess(String message) {
    Get.snackbar(
      'Berhasil',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColor.blue100,
      colorText: AppColor.black,
      borderRadius: 10,
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 3),
    );
  }

  void dialogError(String message) {
    Get.snackbar(
      'Gagal',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red[600],
      colorText: Colors.white,
      borderRadius: 10,
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 3),
    );
  }

}
