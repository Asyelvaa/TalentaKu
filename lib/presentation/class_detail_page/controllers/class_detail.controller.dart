import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_talentaku/domain/models/class_model.dart';
import 'package:flutter_talentaku/domain/models/member_class_model.dart';
import 'package:flutter_talentaku/domain/models/task_model.dart';
import 'package:flutter_talentaku/infrastructure/dal/services/api_services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../../../domain/models/album_model.dart';
import '../../../infrastructure/theme/theme.dart';
import '../../student_report_form/model/Student.dart';

class ClassDetailController extends GetxController {
  final ApiService apiService = ApiService();

  RxList<MemberClassModel> classMembers = <MemberClassModel>[].obs;
  RxList<Album> albums = <Album>[].obs;
  
  RxList<Task> tasks = <Task>[].obs;
    final RxList<Student> selectedStudents = <Student>[].obs;
  var isLoading = true.obs;
  late Map<String, dynamic> classItem;
  final box = GetStorage();
  final RxList<Student> students = <Student>[].obs;
    final username = GetStorage().read('dataUser')?['username'];
  Rx<File?> image = Rx<File?>(null);
  final TextEditingController classNameController = TextEditingController();
  final TextEditingController classDescController = TextEditingController();
  final TextEditingController classLevelController = TextEditingController();

  var grade = GradeModel(
    name: '',
    desc: '',
    level: '',
    uniqueCode: '',
    teacherId: 0,
    updatedAt: '',
    createdAt: '',
    id: 0,
    member: [],
    isactive: '',
  ).obs;

  @override
  void onInit() {
    super.onInit();
    classItem = Get.arguments as Map<String, dynamic>;
    print(classItem['id']);
    fetchAlbums();
    fetchGradeDetails();
    fetchTasks();
    fetchStudentsFromApi();
        _loadStoredImage(); 
    print(username);
    

    classNameController.text = grade.value.name;
    classDescController.text = grade.value.desc;
    classLevelController.text = grade.value.level.toString();
  }

    void _loadStoredImage() {
    String? storedImagePath = box.read('profile_image_path');
    if (storedImagePath != null) {
      image.value = File(storedImagePath);
    }
  }

  Future<void> fetchGradeDetails() async {
    try {
      GradeModel gradeDetail =
          await apiService.getDetailClass(classItem['id'].toString());
      grade.value = gradeDetail;
      classMembers.assignAll(gradeDetail.member);

      print('Detail class: $gradeDetail');
      print('Class members: $classMembers');
    } catch (e) {
      print('Error fetching grade details: $e');
    }
  }

  void toggleActiveStatus(bool isActive) async {
    await apiService.classStatus(grade.value.id);
    grade.update((val) {
      val!.isactive = isActive ? 'active' : 'inactive';
    });
  }

  void fetchAlbums() async {
    try {
      isLoading(true);
      var fetchedAlbums = await apiService.fetchAlbum(classItem['id']);
      albums.assignAll(fetchedAlbums);
      for (var album in albums) {
        print('Album: ${album.desc}');
        print('Album media: ');
        for (var media in album.media) {
          print('Media: ${media.filePath}');
        }
      }
    } catch (e) {
      print('Error fetching albums: $e');
    } finally {
      isLoading(false);
    }
  }

  void fetchStudentsFromApi() async {
    isLoading.value = true;
    final token = box.read('token');
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    final url = 'https://talentaku.site/api/grades/teacher';

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final List<dynamic> grades = jsonResponse['data'];
        students.clear();

        for (var grade in grades) {
          if (grade['members'] != null) {
            final List<dynamic> members = grade['members'];
            students.addAll(
                members.map((member) => Student.fromJson(member)).toList());
          }
        }

        print("Fetched students data: ${students}");
      } else {
        Get.snackbar(
            'Error', 'Failed to fetch students: ${response.statusCode}',
            backgroundColor: AppColor.red);
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

  void fetchTasks() async {
    try {
      isLoading(true);
      var fetchedTasks =
          await ApiService().fetchTask(classItem['id'].toString());
      print(fetchedTasks);
      tasks.assignAll(fetchedTasks);
        } finally {
      isLoading(false);
    }
  }

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
