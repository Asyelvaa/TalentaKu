import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';
import '../global_component/back_appbar.dart';
import 'component/content_nilai.dart';
import 'component/content_tugas.dart';
import 'controllers/assignment_page.controller.dart';

class AssignmentPageScreen extends GetView<AssignmentPageController> {
  const AssignmentPageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: BackAppbar(titleAppbar: 'Judul Tugas')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TabBar(
              controller: controller.tabController,
              tabs: [
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
                children: [
                  ContentTugas(),
                  ContentNilai(),
                ],
              ), 
            )
          ],
        ),
      ),
    );
  }
}
