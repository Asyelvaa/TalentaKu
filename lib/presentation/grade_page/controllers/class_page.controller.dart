  import 'package:get/get.dart';

import '../../profile_page/model/user_model.dart';

  class ClassController extends GetxController {
    //TODO: Implement GradeController
    var classes = <String>[].obs;
    var archivedClasses = <String>[].obs;

    void addClass(String newClass) {
      classes.add(newClass);
    }

    void archiveClass(String className) {
      classes.remove(className);
      archivedClasses.add(className);
    }
    var currentUser = UserModel(
    id: "1",
    name: "Sekar Annisa",
    email: "sekar@example.com",
    birthDate: "1990-05-15",
    photoProfile: "assets/images/student.png",
    address: "Kuman rt 9 rw 1, kec. Batang, kab. Batang",
    role: "teacher",
  ).obs;
  
    final count = 0.obs;
    @override
    void onInit() {
      super.onInit();
    }

    @override
    void onReady() {
      super.onReady();
    }

    @override
    void onClose() {
      super.onClose();
    }

    void increment() => count.value++;
  }
