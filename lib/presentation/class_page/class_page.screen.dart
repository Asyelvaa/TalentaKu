import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/models/class_model.dart';
import '../../infrastructure/theme/theme.dart';
import '../global_component/default_appbar.dart';
import 'component/button_class_form.dart';
import 'component/class_item.dart';
import 'controllers/class_page.controller.dart';

class ClassScreen extends StatelessWidget {

  ClassScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClassController());
    return Scaffold(
      backgroundColor: AppColor.background, 
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultAppbar(),
      ),
      body: Obx(() {
        if (controller.gradesList.isEmpty) {
          return Container(
            height: heightScreen,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                defaultHeightSpace,
                Image.asset("assets/images/stiker_kelas.png", scale: 2.5,),
                Text('Anda Belum Bergabung \nDalam Kelas', 
                  style: AppTextStyle.tsTitle.copyWith(color: AppColor.blue800), textAlign: TextAlign.center,
                ),
                defaultHeightSpace,
                ButtonClassForm(),
              ],
            ),
          );
        } else{
          return SingleChildScrollView(
          child: Container(
            height: double.maxFinite,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: 
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                defaultHeightSpace,
                ButtonClassForm(),
                Expanded(
                  child: ClassItem()
                ),
              ],
            ),
          ),
        );
        }
      }),
    );
  }
}

