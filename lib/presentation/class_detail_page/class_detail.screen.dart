import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'component/header_class.dart';
import 'component/class_appbar.dart';
import 'component/album/content_album.dart';
import 'component/beranda/content_beranda.dart';
import 'component/materi_tugas/content_assignment.dart';
import '../../infrastructure/theme/theme.dart';
import 'controllers/class_detail.controller.dart';

class ClassDetailScreen extends GetView<ClassDetailController> {
  const ClassDetailScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final classItem = controller.classItem;
    // final dataClass = controller.dataClass.value;
    return  DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: ClassAppbar(
            titleAppbar: classItem['name'],
            grade: classItem,
          ),
        ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HeaderClass(),
          Container(
            child: TabBar(
              dividerColor: AppColor.background,
              indicatorColor: AppColor.blue400,
              labelColor: AppColor.black,
              labelStyle: AppTextStyle.tsLittle,
              tabs: [
                Tab(text: 'Beranda'),
                Tab(text: 'Materi & Tugas'),
                Tab(text: 'Album'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                ContentBeranda(),
                ContentAssignment(),
                ContentAlbum(),
              ],
            ),
          ),      
        ],
      ),
    ));
  }
}
