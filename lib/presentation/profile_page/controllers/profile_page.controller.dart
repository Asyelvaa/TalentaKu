import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../domain/models/user_model.dart';
import '../../../infrastructure/dal/services/api_services.dart';
import '../../../infrastructure/navigation/routes.dart';

class ProfilePageController extends GetxController {
  
  final box = GetStorage();
  var isLoading = false.obs;
  var currentUser = Rxn<UserModel>();
  final userData = {}.obs;
  final role = [].obs;
  // final grade = [].obs;
  var userRole = <String>[].obs; 

  final username = GetStorage().read('dataUser')?['username'];
  final roles = GetStorage().read('dataUser')?['role'];

  @override
  void onInit() {
    fetchUser();
    // getUserData();
    // loadUserData();
    super.onInit();
    fetchCurrentUser();
  }

  // Future<void> getUserData() async  {
  //   try {
  //     isLoading.value = true;
  //     var data = await ApiService().getUserData();
  //     currentUser.value = data;
  //     print('User data: ${currentUser.value}');
  //   } finally {
  //     isLoading.value = false;
  //   }
  // } 
  
  void fetchCurrentUser() {
    final box = GetStorage();
    Map<String, dynamic>? dataUser = box.read('dataUser');
    if (dataUser != null) {
      userRole.value = List<String>.from(dataUser['role']);
    }
  }

  Future<void> fetchUser() async {
    try {
    final fetchedUser = await ApiService().getCurrentUser();
    // currentUser.value = UserModel.fromJson(fetchedUser);
    // print('User data: ${currentUser.value}');
    userData.value = fetchedUser['user'];
    role.value = List<String>.from(fetchedUser['roles']);
    // grade.value = List<String>.from(fetchedUser['grades']);
    // print('User data: ${userData.value}');
    // print('Roles: ${role.value}');
    // currentUser.value = fetchedUser;
    // print(fetchedUser.toJson());
    } catch (e){
      print('failed load user data: $e');
    }
  }

  // Future<void> fetchUser() async {
  //   try {
  //     final fetchedUser = await ApiService().getCurrentUser();
  //     if(fetchedUser != null) {

  //       box.write('fetchedUser', fetchedUser.toJson());
  //       box.write('fetchedRoles', fetchedUser.roles);
  //       box.write('fetchedGrades', fetchedUser.grades.map((grade) => grade.toJson()).toList());

  //       currentUser.value = fetchedUser;

  //       Map<String, dynamic>? storedUser = box.read('fetchedUser');
  //       final storedRoles = box.read('fetchedRoles');
  //       final storedGrades = box.read('fetchedGrades');
  //       print({
  //         'storedUser': storedUser,
  //         'storedRoles': storedRoles,
  //         'storedGrades': storedGrades,
  //       });

  //     }
  //   } catch (e) {
  //     print('failed load user data: $e');
  //   }
  // }

  // UserModel? loadUserData() {
  //   var userData = box.read('user');
  //   if (userData != null) {
  //     return UserModel.fromJson(userData);
  //   }
  //   return null;
  // }

  Future<void> logout() async {
    await ApiService().logout();
    box.erase();
    Get.offAllNamed(Routes.LoginScreen);
  }
}
