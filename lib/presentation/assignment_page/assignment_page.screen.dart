import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/assignment_page/component/content_assignment.dart';
import 'package:flutter_talentaku/presentation/assignment_page/component/content_assignment_submit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../infrastructure/theme/theme.dart';
import '../common_widget/back_appbar.dart';
import 'component/content_scoring.dart';
import 'controllers/assignment_page.controller.dart';

class AssignmentPageScreen extends StatelessWidget {
  const AssignmentPageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AssignmentPageController());

    return Scaffold(
      backgroundColor: AppColor.background,      
      appBar: AppBar(
        backgroundColor: AppColor.blue600,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back, 
          color: AppColor.white,)),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: heightScreen * 0.04),
            decoration: BoxDecoration(
              color: AppColor.blue600,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/logo_talentaku.png', scale: 12),
                defaultWidthtSpace,
                Column(
                  children: [
                    Text('Tugas Pembelajaran', style: AppTextStyle.tsTitleBold(AppColor.white)),
                    Obx( () => controller.isLoading.value 
                      ? Text('...', style: AppTextStyle.tsSmallRegular(AppColor.white))
                      : Text( DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(controller.taskDetail.value!.startDate!) ?? '',
                              style: AppTextStyle.tsSmallRegular(AppColor.white),
                            ), 
                      )                    
                    
                  ],
                )
              ],
            ),
          ),          
          Obx(() {
            if (controller.isLoading.value) {
              return Expanded(child: Center(child: CircularProgressIndicator(color: AppColor.blue200,)));
            } else if (controller.userRole.contains('Murid SD') || controller.userRole.contains('Murid TK')) {
              return ContentAssignmentSubmit();
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TabBar(
                      controller: controller.tabController,
                      tabs:
                            [
                              Tab(text: 'Deskripsi Tugas'),
                              Tab(text: 'Penilaian Tugas'),
                            ],
                      dividerColor: AppColor.background,
                      indicatorColor: AppColor.blue400,
                      labelColor: AppColor.black,
                      labelStyle: AppTextStyle.tsBodyRegular(AppColor.black),
                      indicatorSize: TabBarIndicatorSize.tab,
                    ),
                    Container(
                      height: heightScreen * 0.7,
                      child: TabBarView(
                        controller: controller.tabController,
                        children: [
                          ContentAssignment(),
                          ContentScoring(taskId: controller.taskId),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }
          ),
        ],
      )
    );
  }
}
