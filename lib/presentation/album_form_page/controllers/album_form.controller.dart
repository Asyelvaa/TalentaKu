import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../infrastructure/dal/services/api_services.dart';


class AlbumFormController extends GetxController {

  final ApiService apiService = ApiService();
  final ImagePicker _picker = ImagePicker();

  late final String gradeId;
  final TextEditingController descriptionController = TextEditingController();
  final RxList<File> selectedMedia = <File>[].obs;
  final RxInt currentPage = 0.obs;
  late PageController pageController;

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
    if (pickedFiles != null) {
      print('pickedFiles: $pickedFiles');
      final files = pickedFiles.map((pickedFile) => File(pickedFile.path)).toList();
      selectedMedia.addAll(files);    
    } else {
      print('No image selected');
    }
  }

  Future<void> uploadAlbumPost(gradeId, void Function(bool) onResult) async {
    bool success = false;
    try {
      print('Starting uploadAlbumPost');
      print('Description: ${descriptionController.text}');
      print('Selected Media: ${selectedMedia.map((file) => file.path).toList()}');
      print('Grade ID: $gradeId');

      final response = await apiService.postAlbum(
        desc: descriptionController.text,
        media: selectedMedia,
        gradeId: gradeId
      );

      print(response);

      if (response['success']) {
        Get.snackbar('success', 'uploaded successfully');
        success = true;
      } 
    } catch (e) {
      Get.snackbar('Error', 'Error uploading album post');
      print('Error uploading album post: $e');
    } finally {
      print('uploadAlbumPost finished');
      onResult(success);
    }
  } 

}

