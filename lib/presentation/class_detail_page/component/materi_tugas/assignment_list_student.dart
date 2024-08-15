import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../domain/models/task_model.dart';
import '../../../../domain/models/task_student_model.dart';
import '../../../../infrastructure/theme/theme.dart';
import '../../controllers/class_detail.controller.dart';
import 'assignment_item.dart';
import 'submission_item.dart';

class AssignmentListStudent extends StatelessWidget {
  const AssignmentListStudent({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClassDetailController());

    return Obx(() {
      if (controller.isLoading.value) {
        return SliverToBoxAdapter(
          child: Center(child: CircularProgressIndicator()),
        );
      } else {
        var tasks = controller.studentTasks;
        var submittedTasks = tasks.where((task) => task.haveSubmit == true).toList();
        var notSubmittedTasks = tasks.where((task) => task.haveSubmit == false).toList();

        return CustomScrollView(
          slivers: [
            ... buildTaskSection(
              title: 'Tugas Belum Dikerjakan:',
              tasks: notSubmittedTasks,
              emptyMessage: 'Tidak ada tugas',
              controller: controller,
              isSubmission: false,
            ),
            ... buildTaskSection(
              title: 'Tugas Sudah Dikerjakan:',
              tasks: submittedTasks,
              emptyMessage: 'Tidak ada tugas yang sudah dikerjakan',
              controller: controller,
              isSubmission: true,
            ),
          ],
        );
      }
    });
  }

  SliverToBoxAdapter buildSectionTitle(String title) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Text(title, style: AppTextStyle.tsBodyBold(AppColor.black)),
      ),
    );
  }

  SliverList buildTaskList({
    required List<TaskStudentModel> tasks,
    required ClassDetailController controller,
    required bool isSubmission,
  }) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          var task = tasks[index];
          if (isSubmission) {
            return SubmissionItem(
              title: task.title ?? 'No title',
              tenggat: task.endDate != null
                  ? 'Tenggat: ${DateFormat('dd-MM-yyyy').format(task.endDate!)}'
                  : 'No end date',
              taskId: task.taskId.toString(),
              gradeId: controller.classItem['id'].toString(),
            );
          } else {
            return AssignmentItem(
              title: task.title ?? 'No title',
              tenggat: task.endDate != null
                  ? 'Tenggat: ${DateFormat('dd-MM-yyyy').format(task.endDate!)}'
                  : 'No end date',
              taskId: task.taskId.toString(),
              gradeId: controller.classItem['id'].toString(),
            );
          }
        },
        childCount: tasks.length,
      ),
    );
  }

  List<Widget> buildTaskSection({
    required String title,
    required List<TaskStudentModel> tasks,
    required String emptyMessage,
    required ClassDetailController controller,
    required bool isSubmission,
  }) {
    return [
      buildSectionTitle(title),
      if (tasks.isEmpty)
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(emptyMessage, style: AppTextStyle.tsBodyRegular(AppColor.black)),
          ),
        )
      else
        buildTaskList(tasks: tasks, controller: controller, isSubmission: isSubmission),
    ];
  }
}
