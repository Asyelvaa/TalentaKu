import 'package:flutter/material.dart';
import 'package:flutter_talentaku/domain/models/task_model.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/component/class_appbar.dart';
import 'package:get/get.dart';

import '../../domain/models/class_model.dart';
import 'component/album/content_album.dart';
import 'component/beranda/content_beranda.dart';
import 'component/header_class.dart';
import '../../infrastructure/theme/theme.dart';
import 'component/materi_tugas/content_materi_tugas.dart';
import 'controllers/class_detail.controller.dart';
 
class ClassDetailScreen extends GetView<ClassDetailController> {
  const ClassDetailScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // final args = Get.arguments as ClassDetailArguments;
    final classItem = Get.arguments as GradeModel;

    return  DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColor.background,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: ClassAppbar(
            titleAppbar: classItem.name,
            grade: classItem,
          ),
        ),
      body: Column(
        children: [
          // HEADER
          HeaderClass(),  
          // BODY
          // if (!classItem.isActive) // Show message if class is archived
          //     Container(
          //       decoration: BoxDecoration(
          //         color: AppColor.red,
          //         borderRadius: BorderRadius.circular(12)
          //       ),
          //       padding: const EdgeInsets.all(12),
          //       margin: EdgeInsets.all(12),
          //       child: Text(
          //         'Class has been archived by your teacher. You can’t add or edit anything',
          //       style: AppTextStyle.tsLittle.copyWith(color: AppColor.white), // Customize the style of the message
          //       ),
          //     ),
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
                ContentMateriTugas(),
                ContentAlbum(),
              ],
            ),
          ),      
        ],
      ),
    ));
  }
}

