import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_talentaku/presentation/AddEditPost/component/card1.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../infrastructure/theme/theme.dart';

class AddEditPostController extends GetxController {
  final count = 0.obs;

  final isPhotoSelected = false.obs;
  final isVideoSelected = false.obs;

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

  Future<void> showBottomSheet() async {
    Get.bottomSheet(Container(
      width: double.infinity,
      height: Get.height * 0.3,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColor.background,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Pilih dari",
              style: GoogleFonts.manrope(
                  fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  isPhotoSelected.value = !isPhotoSelected.value;
                  if (isPhotoSelected.value) {
                    isVideoSelected.value = false;
                  }
                },
                child: Obx(() => Container(
                      width: 96,
                      height: 83,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: isPhotoSelected.value
                              ? AppColor.blue400
                              : AppColor.grey),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo_outlined,
                              color: isPhotoSelected.value
                                  ? AppColor.background
                                  : Colors.black),
                          Text("Foto",
                              style: TextStyle(
                                  color: isPhotoSelected.value
                                      ? AppColor.background
                                      : Colors.black))
                        ],
                      ),
                    )),
              ),
              GestureDetector(
                onTap: () {
                  isVideoSelected.value = !isVideoSelected.value;
                  if (isVideoSelected.value) {
                    isPhotoSelected.value = false;
                  }
                },
                child: Obx(() => Container(
                      width: 96,
                      height: 83,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: isVideoSelected.value
                              ? AppColor.blue400
                              : AppColor.grey),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.video_call_outlined,
                              color: isVideoSelected.value
                                  ? AppColor.background
                                  : Colors.black),
                          Text("Video",
                              style: TextStyle(
                                  color: isVideoSelected.value
                                      ? AppColor.background
                                      : Colors.black))
                        ],
                      ),
                    )),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Center(
              child: Container(
                width: 300,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.grey,
                ),
                child: Center(child: Text("Cancel")),
              ),
            ),
          )
        ],
      ),
    ));
  }
}

class CardSlider extends StatefulWidget {
  @override
  _CardSliderState createState() => _CardSliderState();
}

class _CardSliderState extends State<CardSlider> {
  late PageController _pageController;
  int _currentPage = 0;
  final AddEditPostController _controller = Get.put(AddEditPostController());

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: _currentPage,
      viewportFraction: 0.8,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 333,
      width: double.infinity,
      child: PageView.builder(
        controller: _pageController,
        itemCount: 2,
        allowImplicitScrolling: true,
        onPageChanged: (int index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Container(
              child: card1(),
            ),
          );
        },
      ),
    );
  }
}
