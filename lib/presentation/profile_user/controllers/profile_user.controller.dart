import 'package:get/get.dart';

class ProfileUserController extends GetxController {
  var student = <String, dynamic>{}.obs;
  var isLoading = false.obs;
  final roles = <String>[].obs;
  final grades = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    // final arguments = Get.arguments;
    // if (arguments != null && arguments is Map<String, dynamic>) {
    //   student.value = arguments;
    //   roles.value = List<String>.from(student['roles'] ?? []);
    //   grades.value = List<String>.from(student['grades'] ?? []);
    // } else {
    //   Get.snackbar('Error', 'Invalid arguments passed', backgroundColor: AppColor.red);
    // }
  }

  void increment() => student['count'] = (student['count'] ?? 0) + 1;
}
