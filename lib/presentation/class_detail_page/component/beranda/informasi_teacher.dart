import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/controllers/class_detail.controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../../assignment_page/assignemnt_form_page.screen.dart';
import '../materi_tugas/assignment_item.dart';
import 'annoucement_component.dart';

class InformasiTeacher extends StatelessWidget {
  const InformasiTeacher({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ClassDetailController>();
    var tasks = controller.teacherTasks;

    return CustomScrollView(
      slivers: [
        tasks.isEmpty
            ? SliverToBoxAdapter(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Belum ada tugas yang dibuat",
                      style: AppTextStyle.tsBodyRegular(AppColor.black),
                    ),
                  ),
                ),
              )
            : SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    var task = tasks[index];
                    return AssignmentItem(
                      title: task.title!,
                      tenggat:
                          'Tenggat: ${DateFormat('dd-MM-yyyy').format(task.endDate!)}',
                      taskId: task.id.toString(),
                      gradeId: controller.classItem['id'].toString(),
                    );
                  },
                  childCount: tasks.length,
                ),
              ),
        SliverToBoxAdapter(
          child: AnnouncementComponent(),
        ),
      ],
    );
  }
}
