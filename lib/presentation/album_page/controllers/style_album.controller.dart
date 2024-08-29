import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
// import 'package:image_downloader/image_downloader.dart';
// import 'package:image_downloader/image_downloader.dart';

import '../../../domain/models/album_model.dart';

class AlbumController extends GetxController {
  late PageController pageController;
  final RxInt currentPage = 0.obs;
  late List<Media> mediaList;
  var isLoading = false.obs;

  @override
  void onInit() {
    final Album album = Get.arguments as Album;
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

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
