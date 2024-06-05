import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;

class PickimageController extends GetxController {
  final resultData = RxString("initial");
  final RxString username = RxString("");
  final RxString name = RxString("");
  final RxString address = RxString("");
  final RxString email = RxString("");
  Rx<File?> image = Rx<File?>(null);
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    String? storedImagePath = box.read('profile_image_path');
    if (storedImagePath != null) {
      image.value = File(storedImagePath);
    }
  }

  Future<void> pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    final _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      image.value = File(_file.path);
      box.write('profile_image_path', _file.path);
      update();
      await uploadImageToApi();
    } else {
      print("No image selected");
    }
  }

  Future<void> uploadImageToApi() async {
    final token = box.read('token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var uri = Uri.parse('https://talentaku.site/api/user/update-photo');
    var request = http.MultipartRequest('POST', uri);

    var multipart = await http.MultipartFile.fromPath(
        'file', image!.value!.path,
        filename: path.basename(image.value!.path));
    request.headers.addAll(headers);
    request.files.add(multipart);
    var response = await request.send();

    if (response.statusCode == 200) {
      print("Image uploaded successfully");
      resultData.value = "Image uploaded successfully";
      Get.offNamed(Routes.NAVBAR);
    } else {
      print("Image upload failed");
      resultData.value = "Image upload failed";
    }
  }
}
