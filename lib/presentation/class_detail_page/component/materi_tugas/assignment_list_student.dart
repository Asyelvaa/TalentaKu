import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../controllers/class_detail.controller.dart';
import 'assignment_item.dart';

class AssignmentListStudent extends StatelessWidget {
  const AssignmentListStudent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClassDetailController>(); // Use Get.find() here

    return Obx(() {
      if (controller.isLoading.value) {
        return SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator()),
        );
      } else {
        var tasks = controller.studentTasks;
        var submittedTasks =
            tasks.where((task) => task.haveSubmit == true).toList();
        var notSubmittedTasks =
            tasks.where((task) => task.haveSubmit == false).toList();

        if (submittedTasks.isEmpty && notSubmittedTasks.isEmpty) {
          return SliverToBoxAdapter(
            child: Center(child: Text('No Task / Material Found')),
          );
        } else {
          return CustomScrollView( 
            slivers: [
              if (notSubmittedTasks.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text('Tugas Belum Dikerjakan:',
                        style: AppTextStyle.tsBodyBold(AppColor.black)),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      var task = notSubmittedTasks[index];
                      return MateriItem(
                        title: task.title!,
                        tenggat:
                            'Tenggat: ${DateFormat('dd-MM-yyyy').format(task.endDate!)}',
                        taskId: task.taskId.toString(),
                        gradeId: controller.classItem['id'].toString(),
                      );
                    },
                    childCount: notSubmittedTasks.length,
                  ),
                ),
              ],
              if (submittedTasks.isNotEmpty) ...[
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text('Tugas Sudah Dikerjakan:',
                        style: AppTextStyle.tsBodyBold(AppColor.black)),
                  ),
                ),
                spaceHeightExtraSmall,
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      var task = submittedTasks[index];
                      return MateriItem(
                        title: task.title!,
                        tenggat:
                            'Tenggat: ${DateFormat('dd-MM-yyyy').format(task.endDate!)}',
                        taskId: task.taskId.toString(),
                        gradeId: controller.classItem['id'].toString(),
                      );
                    },
                    childCount: submittedTasks.length,
                  ),
                ),
              ],
            ],
          );
        }
      }
    });
  }
}
