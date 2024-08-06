import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/dal/services/api_user.dart';
import 'package:flutter_talentaku/presentation/class_page/controllers/class_page.controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../../domain/models/album_model.dart';
import '../../../domain/models/class_announcement_model.dart';
import '../../../domain/models/task_model.dart';
import '../../../domain/models/class_model.dart';
import '../../../domain/models/class_member_model.dart';
import '../../../domain/models/task_student_model.dart';
import '../../../domain/models/user_model.dart';
import '../../../infrastructure/dal/services/api_album.dart';
import '../../../infrastructure/dal/services/api_class.dart';
import '../../../infrastructure/dal/services/api_class_announcement.dart';
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
    print(userRole);
    classItem = Get.arguments as Map<String,dynamic>;
    fetchAlbums();
    fetchGradeDetails();
    fetchAllTask();
    // fetchClassStream();
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

  Future<void> toggleActiveStatus(bool isActive) async {
    final controller = Get.put(ClassController());
         try {
        final response = await apiService.classStatus(dataClass.value.id!);
         if (response != null) {
        dataClass.update((val) {
          val!.isActiveStatus = isActive ? 'active' : 'inactive';
        });
        controller.showAllGrades();
        Get.back();
        Get.snackbar(
          'Success',
          'Class status updated to ${isActive ? 'active' : 'inactive'}',
          snackPosition: SnackPosition.TOP,
        );
        print('Class status updated to ${isActive ? 'active' : 'inactive'}');
      } else {
        Get.back();
        Get.snackbar(
          'Error',
          'Failed to update class status',
          snackPosition: SnackPosition.TOP,
        );
      }
      } catch (e) {
        print(e);
      }
    
  }

  void removeMember(String memberId) {
    try {
      apiService.deleteMember(dataClass.value.id!.toString(), memberId);
      classMembers.removeWhere((element) => element.id == memberId);    
      print('Member with id $memberId has been removed');
      print(classMembers.length);
    } catch (e) {
      print('Error removing member: $e');
    }
  }

  void deleteClass() async {
    final controller = Get.put(ClassController());
    final classId = dataClass.value.id!.toString();
    try {
      final response = await apiService.deleteClass(classId);
      controller.showAllGrades();
      Get.back();
       if (response != null && response.statusCode == 200) {
        Get.snackbar('Success', 'Class deleted successfully');
        print('Class with id $classId deleted successfully');
      } else {
        Get.snackbar('Error', 'Failed to delete class');
      }
    } catch (e) {
      print('Error deleting class: $e');
    }
  }

  Future<void> updateGradeDetails() async {
    try {
      String name = classNameController.text.isNotEmpty
          ? classNameController.text
          : dataClass.value.name!;
      String desc = classDescController.text.isNotEmpty
          ? classDescController.text
          : dataClass.value.desc!;
      int levelId = classLevelController.text.isNotEmpty
          ? int.parse(classLevelController.text)
          : dataClass.value.levelId!;

      await apiService.updateClass(name, desc, levelId, dataClass.value.id!.toString());
      dataClass.update((val) {
        if (val != null) {
          val.name = name;
          val.desc = desc;
          val.levelId= levelId;
        }
      });
      Get.back();
      print('Grade updated successfully');
    } catch (e) {
      print('Error updating grade details: $e');
    }
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

  Rx<ClassAnnouncementModel> announcement = ClassAnnouncementModel().obs;
  final TextEditingController announcementController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  var pickedFiles = <File>[].obs;

  // Method to pick image from gallery
  // Future<void> pickImage() async {
  //   final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     File file = File(pickedFile.path);
  //     pickedFiles.add(file);
  //   }
  // }

  // Method to pick video from gallery
  // Future<void> pickVideo() async {
  //   final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     File file = File(pickedFile.path);
  //     pickedFiles.add(file);
  //   }
  // }

  // Method to pick PDF file from storage
  Future<void> pickPdf() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      pickedFiles.add(file);
    }
  }
  Future<void> pickFile() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery) ?? await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedFiles.add(File(pickedFile.path));
    }
  }
  void removeFile(File file) {
     pickedFiles.removeWhere((element) => element.path == file.path);
  }

  // CREATE ANNOUNCEMENT
  Future<void> createAnnouncement() async {
    final gradeId = classItem['id'].toString();
    isLoading(true);
    try {
      final newAnnouncement = await ApiServiceAnnouncements().createAnnouncement(
        announcementController.text, 
        pickedFiles.toList(), 
        gradeId
      );
      announcement.value = newAnnouncement;
      Get.back();
      Get.snackbar('Success', 'Announcement created successfully');
    } catch (e) {
      Get.back();
      Get.snackbar('Error', 'Failed to create announcement');
    } finally {
      isLoading(false);
    }
  }
  // DELETE ANNOUNCEMENT
  Future<void> deleteAnnouncement(String commentId) async {
    final gradeId = classItem['id'].toString();
    isLoading(true);
    try {
      await ApiServiceAnnouncements().deleteAnnouncement(gradeId, commentId);
      Get.snackbar('Success', 'Announcement deleted successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete announcement');
    } finally {
      isLoading(false);
    }
  }

  // GET ALL STREAM 
  var classStream = <String, dynamic>{}.obs;
  // Future<void> fetchClassStream() async {
  //   isLoading(true);
  //   try {
  //     final content = await ApiServiceAnnouncements().getAllClassStream(classItem['id'].toString());
  //     classStream.value = content['data']['content'];
  //     print(classStream);
  //   } catch (e) {
  //     print(e);
  //   } finally {
  //     isLoading(false);
  //   }
  // }
}
