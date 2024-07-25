import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../assignment_page/assignemnt_form_page.screen.dart';
import '../../controllers/class_detail_arguments.dart';
import '../../component/materi_tugas/materi_item.dart';
import '../../controllers/class_detail.controller.dart';
import '../../../../infrastructure/theme/theme.dart';

class ContentMateriTugas extends GetView<ClassDetailController> {
  const ContentMateriTugas({super.key});

  @override
  Widget build(BuildContext context) {
        return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: GestureDetector(
            onTap: () => Get.to(() => AssignemntFormPageScreen(), arguments: controller.classItem.id.toString(),),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: AppColor.blue100,
                ),
                child: Text(
                  'Upload Task / Material',
                  style: AppTextStyle.tsLittle
                ),
              ),
            ),
          ),
        ),
        Obx((){
          if (controller.isLoading.value) {
            return SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (controller.tasks.isEmpty) {
            return SliverToBoxAdapter(
              child: Center(child: Text('No Task / Material Found')),
            );
          } else {
            controller.tasks.sort((a, b) => b.createdAt.compareTo(a.createdAt));
            return CustomScrollView(
              slivers: [
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      var task = controller.tasks[index];
                      return MateriItem(
                        title: task.title,
                        tenggat: 'Tenggat: ${task.endDate}',
                      );
                    },
                    childCount: controller.tasks.length,
                  ),
                ),
              ],
            );
          }
        })
      ],
    );
  }
}