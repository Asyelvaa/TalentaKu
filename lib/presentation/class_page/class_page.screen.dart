import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/class_page/component/add_class_bottomsheet.dart';
import 'package:flutter_talentaku/presentation/class_page/component/join_class_bottomsheets.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';
import '../global_component/default_appbar.dart';
import '../profile_page/model/user_model.dart';
import 'component/class_item.dart';
import 'controllers/class_page.controller.dart';

class ClassScreen extends GetView<ClassController> {
  ClassScreen({Key? key}) : super(key: key);
  
  ClassController controller = Get.put(ClassController());
  void _showAddClassBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return AddClassBottomSheet(
          onAddClass: (newClass) {
            // controller.addClass(newClass);
          },
        );
      },
    );
  }

  void _showJoinClassBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return JoinClassBottomsheets(
          onJoinClass: (classCode) {
            // controller.joinclass(classCode);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
  var currentUser = mockUserList[0].obs;
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultAppbar(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Obx(() {
          if (currentUser.value.classes!.isEmpty){
            return Container(
              height: heightScreen,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/stiker_kelas.png", scale: 2.5,),
                  Text('Anda Belum Bergabung \nDalam Kelas', 
                    style: AppTextStyle.tsTitle.copyWith(color: AppColor.blue800), textAlign: TextAlign.center,
                  ),
                  if (controller.currentUser.value.role == 'teacher')
                  InkWell(
                    onTap: () {
                      if (controller.currentUser.value.role == 'teacher') {
                        _showAddClassBottomSheet(context);
                      } else if (controller.currentUser.value.role == 'student') {
                        _showJoinClassBottomSheet(context);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: AppColor.blue100,
                          borderRadius: BorderRadius.circular(12),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset(
                          "assets/images/logo_talentaku.png", scale: 20,),
                            ),
                            Text(
                              "Klik bagian ini untuk membuat kelas baru",
                              style: AppTextStyle.tsLittle,
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      ),
                    ),                          
                  )
                ],
              ),
            );
          }
          else {
            return ListView.builder(
              itemCount: currentUser.value.classes!.length,
              itemBuilder: (context, index) {
                // return Text(currentUser.value.classes![index]);
                return ClassItem(
                  title: currentUser.value.classes![index],
                  description: "7-9 tahun",
                  image: "assets/images/tambahan2_images.png",
                );
              },
            );
          }          
        }
        ),
      ),
    );
  }
}
