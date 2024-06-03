import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class PickimageController extends GetxController {
  final resultData = RxString("initial");
  // final RxString imagePath = RxString("");
  final RxString username = RxString("");
  final RxString name = RxString("");
  final RxString phone = RxString("");
  final RxString address = RxString("");
  final RxString email = RxString("");

  void resultRegister(
    String username,
    String name,
    String email,
    String phone,
    String address,
    // String imagePath,
  ) {
    resultData.value = "Registration successful";
    print("U'r Profile Page " + resultData.value.toString());
  }

  void updateUserProfile(

    Uint8List? image,
  ) {

  }

  

  // void switchToHomepage() {
  //   Get.off(Homepage());
  // }
}
