import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';

import '../../../domain/models/album_model.dart';

class AlbumController extends GetxController {
  late PageController pageController;
  final RxInt currentPage = 0.obs;
  late List<Media> mediaList;

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
        await ImageDownloader.downloadImage(media.filePath!);
      }
      Get.snackbar('Success', 'All media saved to gallery');
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
