import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/dal/services/api_album.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../infrastructure/theme/theme.dart';
import '../../class_detail_page/controllers/class_detail.controller.dart';


class AlbumFormController extends GetxController {

  final ApiServiceAlbum apiService = ApiServiceAlbum();
  final ImagePicker _picker = ImagePicker();

  late final String gradeId;
  final TextEditingController descriptionController = TextEditingController();
  final RxList<File> selectedMedia = <File>[].obs;
  final RxInt currentPage = 0.obs;
  late PageController pageController;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    gradeId = Get.arguments is String ? Get.arguments : '';
    pageController = PageController()
      ..addListener(() {
        currentPage.value = pageController.page!.round();
      });
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void nextPage() {
    if (pageController.hasClients && currentPage.value < selectedMedia.length - 1) {
      currentPage.value++;
      pageController.animateToPage(
        currentPage.value, 
        duration: Duration(milliseconds: 300), 
        curve: Curves.easeInOut
      );
    }
  }

  void previousPage() {
    if (pageController.hasClients && currentPage.value > 0) {
      currentPage.value--;
      pageController.animateToPage(
        currentPage.value, 
        duration: Duration(milliseconds: 300), 
        curve: Curves.easeInOut
      );
    }
  }

  void removeMedia(File file) {
    selectedMedia.remove(file);
    if (currentPage.value >= selectedMedia.length) {
      currentPage.value = selectedMedia.length - 1;
    }
  }

  Future<void> pickMedia() async {
    final pickedFiles = await _picker.pickMultiImage();
    print('pickedFiles: $pickedFiles');
    final files = pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
    selectedMedia.addAll(files);    
    }

  Future<void> uploadAlbumPost(gradeId) async {
    final controller = Get.put(ClassDetailController());
    try {
      isLoading.value = true;
      print('Starting uploadAlbumPost');
      print('Description: ${descriptionController.text}');
      print('Selected Media: ${selectedMedia.map((file) => file.path).toList()}');
      print('Grade ID: $gradeId');

      final response = await apiService.createAlbum(
        desc: descriptionController.text,
        media: selectedMedia,
        gradeId: gradeId
      );

      print(response);

      if (response['message'] == 'success') {
        controller.fetchAlbums();
        Get.back();
        Get.snackbar('success', 'uploaded successfully');
      } 
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'Error uploading album post');
      print('Error uploading album post: $e');
    } finally {
      isLoading.value = false;
      Get.back();
      print('uploadAlbumPost finished');
    }
  } 
   void dialogSuccess(String message) {
    Get.snackbar(
      'Berhasil',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor:AppColor.blue100,
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

