import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../../infrastructure/dal/services/api_user.dart';
import '../../../infrastructure/navigation/routes.dart';


class PickimageController extends GetxController {

  final ApiServiceUser apiService = ApiServiceUser();
  final box = GetStorage();
  final username = GetStorage().read('dataUser')?['username'];
  final tokenUser = GetStorage().read('token');

  Rx<File?> image = Rx<File?>(null);
  RxBool isLoading = false.obs;

  @override 
  void onInit() {
    super.onInit();
    _loadStoredImage(); 
    print(tokenUser);
  }
  
  void _loadStoredImage() {
    String? storedImagePath = box.read('profile_image_path');
    if (storedImagePath != null) {
      image.value = File(storedImagePath);
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final _image = await ImagePicker().pickImage(source: source);
    if (_image != null) {
      image.value = File(_image.path);
      box.write('profile_image_path', _image.path);
      update();
    } else {
      print("No image selected");
      return;
    }
  }

  Future<void> uploadImageToApi() async {
    isLoading.value = true; 
    try {
      await apiService.postUserProfilePhoto(image.value!.path);
      Get.offNamed(Routes.NAVBAR);
    } catch(e){
      print("Error uploading image: $e");
    } finally {
      isLoading.value = false; 
    }
  }
}