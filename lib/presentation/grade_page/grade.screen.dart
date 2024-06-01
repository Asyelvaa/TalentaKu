import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/grade_page/component/class_form_bottomsheet.dart';
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
      appBar: AppBar(
        title: Text('Selamat Pagi '),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
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
              ),
              InkWell(
                onTap: () => ClassFormBottomsheet(),
                child: Container(
                  width: Get.width,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset("assets/images/tambahan2_images.png"),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Buat Kelas",
                            style: AppTextStyle.tsNormal,
                          ),
                          Text(
                            "Buat kelas baru lorem ipsum dolor sit amet",
                            style: AppTextStyle.tsLittle,
                            )
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
