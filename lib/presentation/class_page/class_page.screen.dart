import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';
import '../common_widget/default_appbar.dart';
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
        preferredSize: Size.fromHeight(heightScreen * 0.075),
        child: DefaultAppbar(),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } 
        else if (controller.gradeList.isEmpty) {
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
                  style: AppTextStyle.tsTitleBold(AppColor.blue800),
                  textAlign: TextAlign.center,
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
                spaceHeightNormal,
                ButtonClassForm(),
                spaceHeightNormal,
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

