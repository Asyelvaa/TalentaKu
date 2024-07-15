import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../infrastructure/theme/theme.dart';
import 'controllers/add_edit_post.controller.dart';

class AddEditPostScreen extends GetView<AddEditPostController> {
  const AddEditPostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.background,
        appBar: AppBar(
          title: const Text(
            'Album',
          ),
          backgroundColor: AppColor.background,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back)),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: CardSlider(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: TextFormField(
                  decoration: const InputDecoration(
                    fillColor: AppColor.background,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(color: AppColor.blue500),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(color: AppColor.blue500),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.showBottomSheet();
                },
                child: Container(
                  height: 50,
                  width: 324,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColor.blue500),
                      borderRadius: BorderRadius.circular(15),
                      color: AppColor.white),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: Row(
                      children: [
                        Icon(Icons.add),
                        Text(
                          "Foto / Vidio Baru",
                          style:
                              GoogleFonts.manrope(fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Container(
                  height: 50,
                  width: 324,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColor.blue100),
                  child: Center(
                      child: Text("Unggah",
                          style: GoogleFonts.manrope(
                              fontWeight: FontWeight.w600))),
                ),
              ),
            ],
          ),
        ));
  }
}
