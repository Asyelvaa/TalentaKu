import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/dal/services/api_user.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../domain/models/album_model.dart';
import '../../../domain/models/task_model.dart';
import '../../../domain/models/class_model.dart';
import '../../../domain/models/class_member_model.dart';
import '../../../domain/models/task_student_model.dart';
import '../../../domain/models/user_model.dart';
import '../../../infrastructure/dal/services/api_album.dart';
import '../../../infrastructure/dal/services/api_class.dart';
import '../../../infrastructure/dal/services/api_task.dart';

class ClassDetailController extends GetxController {

  final ApiServiceClass apiService = ApiServiceClass();

  Rx<GradeModel> dataClass = GradeModel().obs; 
  RxList<ClassMemberModel> classMembers = <ClassMemberModel>[].obs;
  Rx<UserModel> currentUser = UserModel().obs;

  RxList<Album> albums = <Album>[].obs;
  RxList<Task> teacherTasks = <Task>[].obs;
  RxList<TaskStudentModel> studentTasks = <TaskStudentModel>[].obs;
  late Map<String,dynamic> classItem;

  final TextEditingController classNameController = TextEditingController();
  final TextEditingController classDescController = TextEditingController();
  final TextEditingController classLevelController = TextEditingController();

  var isLoading = true.obs;
    late final List<String> userRole;
  
  @override
  void onInit() {
    super.onInit();
    userRole = GetStorage().read('dataUser')['role'];
    inituser();
    classItem = Get.arguments as Map<String,dynamic>;
    print(classItem['id']);
    fetchAlbums();
    fetchGradeDetails();
    fetchAllTask();
  }


  Future<void> inituser() async {
    await getUserData();
    print(currentUser.value.name);
  }

  Future<void> getUserData() async  {
    try {
      isLoading.value = true;
      var data = await ApiServiceUser().getUserData();
      currentUser.value = data;
    } finally {
      isLoading.value = false;
    }
  } 

  Future<void> fetchGradeDetails() async {
    try {
      GradeModel gradeDetail = await apiService.getDetailClass(classItem['id']);
      dataClass.value = gradeDetail;
      classMembers.assignAll(gradeDetail.member!);
      print('Detail class: ${gradeDetail.name}');
      print('Class members: ${classMembers.length}');
    } catch (e) {
      print('Error fetching grade details: $e');
    }
  }

  void toggleActiveStatus(bool isActive) async {
    await apiService.classStatus(dataClass.value.id!);
    dataClass.update((val) {
      val!.isActiveStatus = isActive ? 'active' : 'inactive';
    });
  }

  void fetchAlbums() async {
    try {
      isLoading(true);
      var fetchedAlbums = await ApiServiceAlbum().getAllAlbum(classItem['id']);
      fetchedAlbums.sort((a, b) => b.date!.compareTo(a.date!));
      albums.assignAll(fetchedAlbums);
    } catch (e) {
      print('Error fetching albums: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchAllTask() async {
    var taskList;
    try {
      isLoading(true);
      if (userRole.any((role) => role.contains('Guru'))) {
        taskList =  ApiServiceTask().getAllTaskTeacher(classItem['id'].toString());
        teacherTasks.assignAll(await taskList);
        print(teacherTasks);
      } else if (userRole.any((role) => role.contains('Murid'))) {
        taskList =  ApiServiceTask().getAllTaskStudent(classItem['id'].toString());
        studentTasks.assignAll(await taskList);
        print(studentTasks);
        update();
      }
    } catch(e) {
      print('failed fetch task: $e');
    }
  }
  
  // Update
  // Future<void> updateClass() async {
  //   try{
  //     await apiService.updateClass(
  //       classNameController.text,
  //       classDescController.text,
  //       int.parse(classLevelController.text),
  //       gradeId
  //     );
  //   } catch (e) {
  //     print('Error updating class: $e');
  //   } 
  // }

  // isActive
  // {{localhost}}api/grades/1/toggle-active

  // Delete Member 
  // {{localhost}}api/grades/1/members/7

  // Show by ID


  // Future<void> updateGradeDetails({String? name, String? desc, int? levelId}) async {
  //   try {
  //     await apiService.updateGrade(
  //       classItem['id'],
  //       name ?? grade.value.name,
  //       desc ?? grade.value.desc,
  //       levelId ?? grade.value.level,
  //     );
  //     grade.update((val) {
  //       if (name != null) val!.name = name;
  //       if (desc != null) val!.desc = desc;
  //       if (levelId != null) val!.level = levelId;
  //     });
  //     print('Grade updated successfully');
  //   } catch (e) {
  //     print('Error updating grade details: $e');
  //   }
  // }
}
