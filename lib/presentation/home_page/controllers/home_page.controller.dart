import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/home_page/models/information_data.dart';
import 'package:flutter_talentaku/presentation/home_page/models/program_data.dart';
import 'package:flutter_talentaku/presentation/home_page/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class HomePageController extends GetxController {
  final box = GetStorage();
  var userRole = <String>[].obs;

  final userData = {}.obs;
  final role = [].obs;
  var selectedImages = ''.obs;

  final desc = [].obs;
  final informationList = <Information>[].obs;
  final contentTitles = <String>[].obs;
  final contenExtra = <String>[].obs;
  final contact = <String>[].obs;
  final contactandinformation = [].obs;
  final extra = [].obs;
  final programs = [].obs;
  Rx<File?> image = Rx<File?>(null);
  var isLoading = false.obs;
  var user = UserModel(
    id: 0,
    name: '',
    desc: '',
    photo: '',
    category_id: '',
    createdAt: '',
    updatedAt: '',
  ).obs;

  String getUsername() {
    final username = box.read('username');
    return username;
  }

  void pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImages.value = pickedFile.path;
    }
  }

  Future<void> fetchProgram() async {
    final url = "https://talentaku.site/api/programs/category/1";
    var headers = {
      'Accept': 'Application/json',
    };
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final items = jsonData['data'];
        contentTitles.clear();
        programs.clear();
        for (var item in items) {
          contentTitles.add(item['name']);
          programs.add(item);
        }

        isLoading.value = false;
      } else {
        throw Exception("Failed to fetch programs");
      }
    } catch (e) {
      print(e);
      throw Exception('Error fetching programs: $e');
    }
  }

  Future<void> fetchExtra() async {
    final url = "https://talentaku.site/api/programs/category/2";
    var headers = {
      'Accept': 'Application/json',
    };
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final items = jsonData['data'];
        contenExtra.clear();
        extra.clear();
        for (var item in items) {
          contenExtra.add(item['name']);
          extra.add(item);
        }
        isLoading.value = false;
      } else {
        throw Exception("Failed to fetch programs");
      }
    } catch (e) {
      print(e);
      throw Exception('Error fetching programs: $e');
    }
  }

  Future<void> updateProgram(
    int id,
    String name,
    String desc,
    File photo,
    int categoryId,
  ) async {
    final token = box.read('token');
    final url = "https://talentaku.site/api/programs/$id";

    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);

      // Add text fields to the request
      request.fields['name'] = name;
      request.fields['desc'] = desc;
      request.fields['category_id'] = categoryId.toString();

      // Add the photo file to the request
      request.files.add(
        await http.MultipartFile.fromPath(
          'photo',
          photo.path,
          contentType: MediaType(
            'image',
            'jpeg',
          ), // Adjust this to the correct file type
        ),
      );

      // Send the request
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print("Response status: ${response.statusCode}");
      print(photo.path);
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print("Update Success: ${responseData['message']}");
        print(responseData);
        Get.back();
      } else {
        final responseData = json.decode(response.body);
        throw Exception('Error: ${responseData['message']}');
      }
    } catch (e) {
      print('Error updating program: $e');
      throw Exception('Error updating program: $e');
    }
  }

  Future<void> deleteProgram(int id) async {
    final token = box.read('token');
    final url = "https://talentaku.site/api/programs/$id";
    var headers = {
      'Accept': 'Application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      final response = await http.delete(Uri.parse(url), headers: headers);

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        fetchProgram();
        Get.snackbar('Success', 'Program deleted successfully');
      } else if (response.statusCode == 404) {
        throw Exception("Program not found");
      } else {
        throw Exception("Failed to delete program");
      }
    } catch (e) {
      print('Error deleting program: $e');
      Get.snackbar('Error', 'Failed to delete program: $e');
      throw Exception('Error deleting program: $e');
    }
  }

  Future<void> fetchContactAndInformation() async {
    isLoading.value = true;
    final url = "https://talentaku.site/api/information";
    var headers = {
      'Accept': 'Application/json',
    };
    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final items = jsonData['information'];
        for (var item in items) {
          contact.add(item['title']);
          desc.add(item['desc']);
          contactandinformation.add(item);
        }
        isLoading.value = false;
      } else {
        throw Exception("Failed to fetch contact and information");
      }
    } catch (e) {
      throw Exception('Error fetching contact and information: $e');
    }
  }

  Future<void> fetchInformationList() async {
    isLoading.value = true;
    final url = "https://talentaku.site/api/information/list";
    var headers = {
      'Accept': 'Application/json',
    };
    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final List<Information> list = List<Information>.from(
          jsonData.map((x) => Information.fromJson(x)),
        );
        informationList.assignAll(list);
        isLoading.value = false;
      } else {
        throw Exception("Failed to fetch information list");
      }
    } catch (e) {
      print("Error fetching information list: $e");
      throw Exception('Error fetching information list: $e');
    }
  }

  @override
  void onInit() {
    fetchContactAndInformation();
    fetchInformationList();
    fetchProgram();
    fetchExtra();
    super.onInit();
    fetchCurrentUser();
  }

  void fetchCurrentUser() {
    final box = GetStorage();
    Map<String, dynamic>? dataUser = box.read('dataUser');
    if (dataUser != null) {
      userRole.value = List<String>.from(dataUser['role']);
    }
  }

  // Future<void> showBottomSheet() async {
  //   Get.bottomSheet(
  //     backgroundColor: AppColor.background,
  //     isScrollControlled: true,
  //     Container(
  //       width: double.infinity,
  //       height: Get.height * 0.6,
  //       padding: EdgeInsets.all(15),
  //       child: Column(
  //         children: [
  //           Text(
  //             "Terapi Wicara",
  //             style: GoogleFonts.manrope(
  //               fontWeight: FontWeight.w600,
  //               fontSize: 16,
  //             ),
  //           ),
  //           SizedBox(height: 15),
  //           Image.asset("assets/images/wacara.png"),
  //           SizedBox(height: 20),
  //           Text(
  //             "This subheader is pinned to the top so you can adjust the symbol height as necessary. Bottom padding should be 16px.This subheader is pinned to the top so you can adjust the symbol height as necessary. Bottom padding should be 16px.",
  //             style: GoogleFonts.manrope(
  //               fontWeight: FontWeight.normal,
  //               fontSize: 12,
  //             ),
  //             textAlign: TextAlign.center,
  //           ),
  //           SizedBox(height: 5),
  //           GestureDetector(
  //             onTap: () {
  //               Get.back();
  //             },
  //             child: Container(
  //               width: double.infinity,
  //               height: 50,
  //               alignment: Alignment.center,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(10),
  //                 color: AppColor.blue300,
  //               ),
  //               child: Text("Kembali"),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
