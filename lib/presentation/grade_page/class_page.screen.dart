import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/grade_page/component/class_form_bottomsheet.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';
import '../global_component/default_appbar.dart';
import 'component/class_item.dart';
import 'controllers/class_page.controller.dart';

class ClassScreen extends GetView<ClassController> {
  ClassScreen({Key? key}) : super(key: key);
  final ClassController classController = Get.put(ClassController());

  void _showAddClassBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AddClassBottomSheet(
          onAddClass: (newClass) {
            classController.addClass(newClass);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultAppbar(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
          child: Column(
            children: [
              if (classController.classes.isEmpty &&
                  classController.archivedClasses.isEmpty)
                Center(
                  child: Column(
                    children: [
                      Text('Anda Belum Bergabung Dalam Kelas'),
                      //if (classController.currentUser.value.role == 'teacher')
                        InkWell(
                          onTap: () => _showAddClassBottomSheet(context),
                          child: Container(
                            width: Get.width,
                            padding: EdgeInsets.symmetric(
                                vertical: 16, horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                    "assets/images/tambahan2_images.png"),
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
                        ),
                    ],
                  ),
                ),
              if (classController.classes.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: classController.classes.length,
                    itemBuilder: (context, index) {
                      return ClassItem(
                        title: "Nama Kelompok",
                        description: "7-9 tahun",
                        image: "assets/images/tambahan2_images.png",
                      );
                    },
                  ),
                ),
              if (classController.archivedClasses.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: classController.archivedClasses.length,
                    itemBuilder: (context, index) {
                      return ClassItem(
                        title: "Nama Kelompok",
                        description: "7-9 tahun",
                        image: "assets/images/tambahan2_images.png",
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
