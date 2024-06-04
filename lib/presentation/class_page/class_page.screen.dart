import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';
import '../global_component/default_appbar.dart';
import '../profile_page/model/user_model.dart';
import 'component/button_class_form.dart';
import 'component/class_item.dart';
import 'controllers/class_page.controller.dart';

class ClassScreen extends GetView<ClassController> {
  ClassScreen({Key? key}) : super(key: key);
  
  ClassController controller = Get.put(ClassController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultAppbar(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(() {
          final currentUser = controller.currentUser.value;
          if (currentUser.grades.isEmpty){
            return Container(
              height: heightScreen,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/stiker_kelas.png", scale: 2.5,),
                  Text('Anda Belum Bergabung \nDalam Kelas', 
                    style: AppTextStyle.tsTitle.copyWith(color: AppColor.blue800), textAlign: TextAlign.center,
                  ),
                  ButtonClassForm(),                          
                ],
              ),
            );
          }
          else {
            return Column(
              children: [
                ButtonClassForm(),
                ListView.builder(
                  itemCount: currentUser.grades.length,
                  itemBuilder: (context, index) {
                    // return Text(currentUser.value.classes![index]);
                    return ClassItem(
                      title: currentUser.grades[index],
                      description: "7-9 tahun",
                      image: "assets/images/tambahan2_images.png",
                    );
                  },
                ),
              ],
            );
          }          
        }
        ),
      ),
    );
  }
}

