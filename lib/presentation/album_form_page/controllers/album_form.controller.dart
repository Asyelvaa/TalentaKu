import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../infrastructure/dal/services/api_services.dart';


class AlbumFormController extends GetxController {
  late final String gradeId;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController descriptionController = TextEditingController();
  final ApiService apiService = ApiService();
  final RxList<File> selectedMedia = <File>[].obs;
  final RxInt currentPage = 0.obs;
  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    final dynamic args = Get.arguments;
    gradeId = args is String ? args : '';
    pageController = PageController();
    pageController.addListener(() {
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
      pageController.animateToPage(currentPage.value, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void previousPage() {
    if (pageController.hasClients && currentPage.value > 0) {
      currentPage.value--;
      pageController.animateToPage(currentPage.value, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
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

  Future<void> uploadAlbumPost(gradeId) async {
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
      }
    }  on SocketException catch (socketException) {
      Get.snackbar('Error', 'Network error uploading album post');
      print('SocketException uploading album post: ${socketException.message}');
    } on HttpException catch (httpException) {
      Get.snackbar('Error', 'HTTP error uploading album post');
      print('HttpException uploading album post: ${httpException.message}');
    } on FormatException catch (formatException) {
      Get.snackbar('Error', 'Format error uploading album post');
      print('FormatException uploading album post: ${formatException.message}');
    } catch (e, stackTrace) {
      Get.snackbar('Error', 'Error uploading album post');
      print('Error uploading album post: $e');
      print('Stack trace: $stackTrace');
    } finally {
      print('uploadAlbumPost finished');
    }
  } 

}

