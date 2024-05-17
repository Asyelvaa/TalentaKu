import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';
import 'component/class_item.dart';
import 'controllers/grade.controller.dart';

class GradeScreen extends GetView<GradeController> {
  const GradeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return ClassItem(
                      title: "Nama Kelompok",
                      description: "7-9 tahun",
                      image: "assets/images/tambahan2_images.png",
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
