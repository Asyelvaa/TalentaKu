import 'dart:io';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../../infrastructure/dal/services/api_services.dart';
import '../../../infrastructure/navigation/routes.dart';


class PickimageController extends GetxController {

  final ApiService apiService = ApiService();
  final box = GetStorage();
  final username = GetStorage().read('dataUser')?['username'];
  Rx<File?> image = Rx<File?>(null);
  RxBool isLoading = false.obs;

  @override 
  void onInit() {
    super.onInit();
    _loadStoredImage(); 
    print(username);
  }
  
  void getInitials() {
    
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
      await apiService.uploadImageToApi(image.value!.path);
      Get.offNamed(Routes.NAVBAR);
    } catch(e){
      print("Error uploading image: $e");
    } finally {
      isLoading.value = false; 
    }
  }
}