import 'package:flutter_talentaku/domain/models/class_model.dart';
import 'package:flutter_talentaku/infrastructure/dal/services/api_services.dart';
import 'package:get/get.dart';

import '../../../domain/models/album_model.dart';

class ClassDetailController extends GetxController {
  final ApiService apiService = ApiService();

  var albums = <Album>[].obs;
  var isLoading = true.obs;
  late String gradeId;
  final GradeModel classItem = Get.arguments as GradeModel;

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
    gradeId = classItem.id.toString();
    fetchAlbums();
  }

  void fetchGradeDetails() async {
    try {
      GradeModel fetchDetailClass = await apiService.getDetailClass(grade.value.id);
      print('Detail class: $fetchDetailClass' );
      
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
      var fetchedAlbums = await apiService.fetchAlbum(gradeId);
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
}
