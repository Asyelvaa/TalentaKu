import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../../../domain/models/album_model.dart';
import '../../../domain/models/class_announcement_model.dart';
import '../../../domain/models/class_member_model.dart';
import '../../../domain/models/task_model.dart';
import '../../../domain/models/task_student_model.dart';
import '../../../domain/models/grade_model.dart';
import '../../../presentation/student_report_form/model/Student.dart';
import '../../../infrastructure/dal/services/api_album.dart';
import '../../../infrastructure/dal/services/api_class.dart';
import '../../../infrastructure/dal/services/api_class_announcement.dart';
import '../../../infrastructure/dal/services/api_task.dart';
import '../../../infrastructure/theme/theme.dart';
import '../../class_page/controllers/class_page.controller.dart';

class ClassDetailController extends GetxController with GetTickerProviderStateMixin {
  final ApiServiceClass _apiServiceClass = ApiServiceClass();
  final ApiServiceAlbum _apiServiceAlbum = ApiServiceAlbum();
  final ApiServiceTask _apiServiceTask = ApiServiceTask();
  final ApiServiceAnnouncements _apiServiceAnnouncements = ApiServiceAnnouncements();

  Rx<GradeModel> dataClass = GradeModel().obs;
  RxList<ClassMemberModel> classMembers = <ClassMemberModel>[].obs;
  // Rx<UserModel> currentUser = UserModel().obs;
  RxList<Student> selectedStudents = <Student>[].obs;
  RxList<Student> students = <Student>[].obs;
  RxList<Album> albums = <Album>[].obs;
  RxList<Task> teacherTasks = <Task>[].obs;
  RxList<TaskStudentModel> studentTasks = <TaskStudentModel>[].obs;
  Rx<File?> image = Rx<File?>(null);
  RxBool isLoading = false.obs;

  final TextEditingController classNameController = TextEditingController();
  final TextEditingController classDescController = TextEditingController();
  final TextEditingController classLevelController = TextEditingController();
  final TextEditingController announcementController = TextEditingController();

  late List<String> userRole;
  late TabController tabController;
  late Map<String, dynamic> classItem;
  var username = ''.obs;
  final announcement = ClassAnnouncementModel().obs;
  final ImagePicker _picker = ImagePicker();
  final RxList<File> pickedFiles = <File>[].obs;
  final box = GetStorage();


  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 3, vsync: this);
    userRole = GetStorage().read('dataUser')['role'];
    username.value = GetStorage().read('dataUser')?['username'];
    classItem = Get.arguments as Map<String, dynamic>;
    print({username, userRole.toString()});

    fetchAlbums();
    fetchGradeDetails();
    fetchAllTask();
    fetchStudentsFromApi();
    fetchStream();
  }


  Future<void> fetchGradeDetails() async {
    try {
      GradeModel gradeDetail = await _apiServiceClass.getDetailClass(classItem['id']);
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
      final response = await _apiServiceClass.classStatus(dataClass.value.id!);
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
      _apiServiceClass.deleteMember(dataClass.value.id!.toString(), memberId);
      classMembers.removeWhere((element) => element.id == memberId);
      fetchGradeDetails();
      Get.snackbar('Success', 'Member removed successfully');
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
      final response = await _apiServiceClass.deleteClass(classId);
      if (response != null && response.statusCode == 200) {
        Get.snackbar('Success', 'Class deleted successfully');
        print('Class with id $classId deleted successfully');
        controller.showAllGrades();
      } else {
        Get.snackbar('Error', 'Failed to delete class');
      }
      Get.back();
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

      await _apiServiceClass.updateClass(
          name, desc, levelId, dataClass.value.id!.toString());
      dataClass.update((val) {
        if (val != null) {
          val.name = name;
          val.desc = desc;
          val.levelId = levelId;
        }
      });
      fetchGradeDetails();
      Get.back();
      Get.snackbar('Success', 'Grade updated successfully');
      print('Grade updated successfully');
    } catch (e) {
      print('Error updating grade details: $e');
    }
  }

  Future<void> fetchAlbums() async {
    try {
      isLoading(true);
      var fetchedAlbums = await _apiServiceAlbum.getAllAlbum(classItem['id']);
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
        taskList =
            _apiServiceTask.getAllTaskTeacher(classItem['id'].toString());
        teacherTasks.assignAll(await taskList);
        print(teacherTasks);
      } else if (userRole.any((role) => role.contains('Murid'))) {
        taskList =
            _apiServiceTask.getAllTaskStudent(classItem['id'].toString());
        studentTasks.assignAll(await taskList);
        print(studentTasks);
        update();
      }
    } catch (e) {
      print('failed fetch task: $e');
    }
  }

  void fetchStudentsFromApi() async {
    isLoading.value = true;
    final token = box.read('token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = 'https://talentaku.site/api/grades/${classItem['id']}';

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final data = jsonResponse['data'];
        if (data != null && data['members'] is List) {
          final List<dynamic> members = data['members'];
          students.clear(); 
          for (var member in members) {
            if (member != null && member['id'] != null) {
              if (!students.any((student) => student.id == member['id'])) {
                students.add(Student.fromJson(member));
              }
            }
          }
        }
        print("Fetched students data: ${students}");
      } else {
        print('error fetching students: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred', backgroundColor: AppColor.red);
    } finally {
      isLoading.value = false;
    }
  }

  void toggleSelection(Student student) {
    if (selectedStudents.contains(student)) {
      selectedStudents.remove(student);
    } else {
      selectedStudents.add(student);
    }
  }

  // Method to pick video from gallery
  // Future<void> pickVideo() async {
  //   final XFile? pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     File file = File(pickedFile.path);
  //     pickedFiles.add(file);
  //   }
  // }

  // Method to pick PDF file from storage


  Future<void> pickFile() async {
    FilePickerResult? pdfResult = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (pdfResult != null && pdfResult.files.single.path != null) {
      File pdfFile = File(pdfResult.files.single.path!);
      pickedFiles.add(pdfFile);
      return;
    }
    final XFile? pickedFile =
      await _picker.pickImage(source: ImageSource.gallery);
      // await _picker.pickVideo(source: ImageSource.gallery);
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
    print(announcementController.text);
    print(pickedFiles.toString());
    try {
      final newAnnouncement = await 
      ApiServiceAnnouncements().createAnnouncement(
        announcementController.text, 
        pickedFiles.toList(), 
        gradeId);
      announcement.value = newAnnouncement;
      Get.back();
      dialogSuccess('Pengumuman berhasil dibuat');
    } catch (e) {
      Get.back();
      dialogError('Gagal membuat pengumuman');
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
      print('berhasil hapus announcement ');
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete announcement');
      print('Gagal hapus announcement ');
    } finally {
      isLoading(false);
    }
  }

  var tasklist = [].obs;
  var announcementsList = [].obs;
  var anounces = [].obs;
  var mediaAnnounce = [].obs;
  // List<StreamItem> parseContentItems(List<dynamic> data) {
  // return data.map((item) => StreamItem.fromJson(item)).toList();
  // }

  // var streamItems = <StreamItem>[].obs;

  // Future<void> fetchStream() async {
  //   final gradeId = classItem['id'];
  //   try {
  //     isLoading.value = true;
  //     final response = await http.get(Uri.parse(
  //         'https://talentaku.site/api/grades/$gradeId/grade-content'));
  //     if (response.statusCode == 200) {
  //       final jsonResponse = json.decode(response.body);
  //       streamItems.value = parseContentItems(jsonResponse['data']);
  //     } else {
  //       throw Exception('Failed to load content');
  //     }
  //   } catch (e) {
  //     print(e);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  Future<void> fetchStream() async {
    late final token = box.read('token');
    final gradeId = classItem['id'].toString();
    final url = 'https://talentaku.site/api/grades/$gradeId/announcements';
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> datas = json.decode(response.body)['data'];

        for (var data in datas) {
          announcementsList.add({
            'id': data['id'],
            'title': data['title'],
            'announcements': data['announcements'],
            'created_at': data['created_at'],
            'updated_at': data['updated_at'],
            'media': data['media'],
            'user': data['user'],
            'replies_count': data['replies_count'],
          });
        }

        if (announcementsList.isNotEmpty) {
          anounces.value = announcementsList[0]['announcements'];
          // mediaAnnounce.value = announcementsList[0]['media'];
        }

        print("Announcements List: $announcementsList");
      }
    } catch (e) {
      print(e);
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
  void dialogSuccess(String message) {
    Get.snackbar(
      'Berhasil',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColor.blue100,
      colorText: AppColor.black,
      borderRadius: 10,
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 3),
    );
  }

  void dialogError(String message) {
    Get.snackbar(
      'Gagal',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red[600],
      colorText: Colors.white,
      borderRadius: 10,
      margin: EdgeInsets.all(10),
      duration: Duration(seconds: 3),
    );
  }

  @override
  void onClose() {
    // TODO: implement onClose
    announcementController.dispose();
    pickedFiles.clear();
    super.onClose();
  }
}
