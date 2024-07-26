import 'package:flutter_talentaku/domain/models/class_model.dart';
import 'package:flutter_talentaku/domain/models/member_class_model.dart';
import 'package:flutter_talentaku/domain/models/task_model.dart';
import 'package:flutter_talentaku/infrastructure/dal/services/api_services.dart';
import 'package:get/get.dart';

import '../../../domain/models/album_model.dart';

class ClassDetailController extends GetxController {

  final ApiService apiService = ApiService();

  RxList<MemberClassModel> classMembers = <MemberClassModel>[].obs;
  RxList<Album> albums = <Album>[].obs;
  RxList<Task> tasks = <Task>[].obs;
  var isLoading = true.obs;
  late GradeModel classItem;

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
    classItem = Get.arguments as GradeModel;

    fetchAlbums();
    fetchGradeDetails();
    fetchTasks();
  }

  Future<void> fetchGradeDetails() async {
    try {
      GradeModel gradeDetail = await apiService.getDetailClass(grade.value.id);
      print('Detail class: $gradeDetail' );
      classMembers.assignAll(gradeDetail.member);
      print(classMembers);
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
      var fetchedAlbums = await apiService.fetchAlbum(classItem.id);
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

  void fetchTasks() async {
    try {
      isLoading(true);
      var fetchedTasks = await ApiService().fetchTask(classItem.id.toString());
      print(fetchedTasks);
      if (fetchedTasks != null) {
        tasks.assignAll(fetchedTasks);
      } else {
        tasks.clear();
      }
    } finally {
      isLoading(false);
    }
  }
}
