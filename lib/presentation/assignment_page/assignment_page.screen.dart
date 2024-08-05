import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/assignment_page/component/content_assignment.dart';
import 'package:flutter_talentaku/presentation/assignment_page/component/content_assignment_submit.dart';
import 'package:get/get.dart';
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: BackAppbar(titleAppbar: 'Detail Tugas',),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
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
                          Tab(text: 'Tugas'),
                          Tab(text: 'Nilai'),
                        ],
                  dividerColor: AppColor.background,
                  indicatorColor: AppColor.blue400,
                  labelColor: AppColor.black,
                  labelStyle: AppTextStyle.tsLittle,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
                Expanded(
                  child: TabBarView(
                    controller: controller.tabController,
                    children:
                         [
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
      )
    );
  }
}
