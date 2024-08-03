import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/controllers/class_detail.controller.dart';
import 'package:get/get.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../../assignment_page/assignemnt_form_page.screen.dart';
import 'assignment_item.dart';

class AssignmentListTeacher extends StatelessWidget {
  const AssignmentListTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClassDetailController>();
    var tasks = controller.teacherTasks;

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: GestureDetector(
            onTap: () => Get.to(() => AssignemntFormPageScreen(), arguments: {
              'taskId': null,
              'gradeId': controller.classItem['id'].toString()
            }),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                alignment: Alignment.center,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColor.blue100,
                ),
                child: Text('Upload Task / Material',
                    style: AppTextStyle.tsSmallBold(AppColor.black)),
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              var task = tasks[index];
              return MateriItem(
                title: task.title!,
                tenggat: 'Tenggat: ${task.endDate}',
                taskId: task.id.toString(),
                gradeId: controller.classItem['id'].toString(),
              );
            },
            childCount: tasks.length,
          ),
        )
      ],
    );
  }
}
