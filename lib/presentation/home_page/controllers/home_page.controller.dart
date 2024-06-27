import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/home_page/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;

class HomePageController extends GetxController {
  final box = GetStorage();

  final userData = {}.obs;
  final role = [].obs;

  final desc = [].obs;

  final contentTitles = [].obs;
  final contact = [].obs;
  final contactandinformation = [].obs;
  final programs = [].obs;
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

  Future<void> fetchUser() async {
    isLoading.value = true;
    final token = box.read('token');
    final url = "https://talentaku.site/api/user";
    var headers = {
      'Accept': 'Application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        userData.value = jsonData['user'];
        print(userData);
        role.value = jsonData['roles'];
        isLoading.value = false;
      } else {
        throw Exception("Haloo");
      }
    } catch (e) {
      throw Exception('Haii');
    }
  }

  Future<void> fetchProgram() async {
    isLoading.value = true;
    final url = "https://talentaku.site/api/programs";
    var headers = {
      'Accept': 'Application/json',
    };
    try {
      final response = await http.get(Uri.parse(url), headers: headers);

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final items = jsonData['programs'];
        for (var item in items) {
          contentTitles.add(item['name']);
          programs.add(item);
        }
        isLoading.value = false;
      } else {
        throw Exception("Haloo");
      }
    } catch (e) {
      print(e);
      throw Exception('Haii');
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
        throw Exception("Haloo");
      }
    } catch (e) {
      throw Exception('Haii');
    }
  }

  @override
  void onInit() {
    fetchUser();
    fetchProgram();
    fetchContactAndInformation();
    // fetchContactAndAddress();
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

  Future<void> showBottomSheet() async {
    Get.bottomSheet(
        backgroundColor: AppColor.background,
        isScrollControlled: true,
        Container(
          width: double.infinity,
          height: Get.height * 0.6,
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Text(
                "Terapi Wicara",
                style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w600, fontSize: 16),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //       // borderRadius: BorderRadius.circular(10),
              //       image: DecorationImage(
              //           image: AssetImage("assets/images/wacara.png"),
              //           fit: BoxFit.fill)),
              // ),
              SizedBox(
                height: 15,
              ),
              Image.asset("assets/images/wacara.png"),
              SizedBox(
                height: 20,
              ),
              Text(
                "This subheader is pinned to the top so you can adjust the symbol height as necessary. Bottom padding should be 16px.This subheader is pinned to the top so you can adjust the symbol height as necessary. Bottom padding should be 16px.",
                style: GoogleFonts.manrope(
                    fontWeight: FontWeight.normal, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 5,
              ),

              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.blue300,
                  ),
                  child: Text("kembali"),
                ),
              )
            ],
          ),
        ));
  }
}
