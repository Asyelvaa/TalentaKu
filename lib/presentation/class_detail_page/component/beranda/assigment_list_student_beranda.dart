import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/component/materi_tugas/assignment_item.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../domain/models/task_model.dart';
import '../../../../domain/models/task_student_model.dart';
import '../../../../infrastructure/theme/theme.dart';
import '../../controllers/class_detail.controller.dart';

class AssigmentBeranda extends StatelessWidget {
  const AssigmentBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClassDetailController());

    SliverToBoxAdapter buildSectionTitle(String title) {
      return SliverToBoxAdapter(
        child: Text(title, style: AppTextStyle.tsBodyBold(AppColor.black)),
      );
    }

    SliverList buildTaskList(
        List<TaskStudentModel> tasks, ClassDetailController controller) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            var task = tasks[index];
            return MateriItem(
              title: task.title ?? 'No title',
              tenggat: task.endDate != null
                  ? 'Tenggat: ${DateFormat('dd-MM-yyyy').format(task.endDate!)}'
                  : 'No end date',
              taskId: task.taskId.toString(),
              gradeId: controller.classItem['id'].toString(),
            );
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
    }) {
      return [
        buildSectionTitle(title),
        if (tasks.isEmpty)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(emptyMessage,
                  style: AppTextStyle.tsBodyRegular(AppColor.black)),
            ),
          )
        else
          buildTaskList(tasks, controller),
      ];
    }

    return CustomScrollView(
      slivers: [
        ...buildTaskSection(
          title: '',
          tasks: controller.studentTasks,
          emptyMessage: 'Tidak ada tugas',
          controller: controller,
        )
      ],
    );
  }
}
