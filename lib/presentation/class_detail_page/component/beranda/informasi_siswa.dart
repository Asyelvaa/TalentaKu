import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/component/materi_tugas/assignment_item.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../domain/models/task_student_model.dart';
import '../../../../infrastructure/theme/theme.dart';
import '../../controllers/class_detail.controller.dart';
import 'annoucement_component.dart';

class InformasiSiswa extends StatelessWidget {
  const InformasiSiswa({super.key});

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
        var notSubmittedTasks =
            tasks.where((task) => task.haveSubmit == false).toList();

        return CustomScrollView(
          shrinkWrap: true,
          slivers: [
            // ...buildTaskSection(
            //   title: 'Informasi',
            //   tasks: notSubmittedTasks,
            //   emptyMessage: 'Tidak ada tugas',
            //   controller: controller,
            // ),
            SliverToBoxAdapter(
              child: AnnouncementComponent(),
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

  SliverList buildTaskList(
      List<TaskStudentModel> tasks, ClassDetailController controller) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          var task = tasks[index];
          return AssignmentItem(
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
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(emptyMessage,
                style: AppTextStyle.tsBodyRegular(AppColor.black)),
          ),
        )
      else
        buildTaskList(tasks, controller),
    ];
  }
}
