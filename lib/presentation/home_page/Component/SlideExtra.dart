import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/home_page/Component/add_new_data.dart';
import 'package:flutter_talentaku/presentation/home_page/Component/add_new_extra.dart';
import 'package:flutter_talentaku/presentation/home_page/controllers/home_page.controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'content.dart';
import 'header_content.dart';

class SlideExtra extends GetView<HomePageController> {
  final String headerContent;
  final List<String> contenExtra;
  final void Function()? onTap;
  final String image;

  SlideExtra({
    Key? key,
    required this.headerContent,
    required this.contenExtra,
    this.onTap,
    required this.image,
  }) : super(key: key);
  final HomePageController _homePageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(children: [
          HeaderContent(text: headerContent, imageName: image),
          Wrap(
            spacing: 10, 
            runSpacing: 10, 
            children: [
              ...contenExtra.map((title) => 
                  GestureDetector(
                    onTap: onTap, 
                    child: Content(
                      contenExtra: title,
                      index: contenExtra.indexOf(title),
                    ),
                  )
                ),         
                if (_homePageController.userRole
                    .any((role) => role.contains('Guru')))
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.black12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(22)),
                        ),
                        builder: (BuildContext context) {
                          return Container(
                            height: heightScreen * 0.7,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(22)),
                              color: AppColor.white,
                            ),
                            child: AddNewData(
                              initialName: controller.nameController.text,
                              initialDesc: controller.descController.text,
                              initialPhoto: controller.selectedImages.value,
                              initialCategoryId: 2.toString(),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: heightScreen * 0.2,
                      width: widthScreen * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColor.white,
                        border: Border.all(color: AppColor.blue600, width: 1),
                      ),
                      child: Icon(Icons.add),
                    ),
                  )
              ],
            ),          
        ]
      ));
  }
}
