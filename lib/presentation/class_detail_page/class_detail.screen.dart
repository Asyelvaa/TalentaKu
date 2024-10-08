import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import 'component/header/class_button_action_student.dart';
import 'component/header/class_button_action_teacher.dart';
import 'component/header/header_class.dart';
import 'component/header/class_appbar.dart';
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
    final RefreshController refreshController =
        RefreshController(initialRefresh: false);

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SmartRefresher(
        controller: refreshController,
        onRefresh: () async {
          await controller.fetchGradeDetails();
          await controller.fetchStream();
          await controller.fetchAllTask();
          await controller.fetchAlbums();
  
          refreshController.refreshCompleted();
        },
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: AppColor.white),
                    onPressed: () => Get.back(),
                  ),
                  expandedHeight: heightScreen * 0.44,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      padding: EdgeInsets.only(
                          top: heightScreen * 0.12, left: 20, right: 20),
                      decoration: BoxDecoration(
                        color: AppColor.blue600,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(classItem['name'],
                              style:
                                  AppTextStyle.tsBigTitleBold(AppColor.white)),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: defaultBorderRadius,
                            ),
                            child: Text(classItem['desc'],
                                style: AppTextStyle.tsSmallRegular(
                                    AppColor.black)),
                          ),
                          defaultHeightSpace,
                          HeaderClass(),
                          Obx(() {
                            if (controller.isLoading.value) {
                              return Shimmer(
                                // duration: Duration(seconds: 2),
                                // color: Colors.grey.shade300,
                                enabled: true,
                                child: Container(
                                  width: widthScreen,
                                  height: heightScreen * 0.07,
                                  decoration: BoxDecoration(
                                    // color: AppColor.blue200,
                                    borderRadius: defaultBorderRadius
                                  ),
                                )
                              );
                            } else 
                            if (controller.userRole.any((role) => role.contains('Guru'))) {
                              return ClassButtonActionTeacher();
                            } else {
                              return ClassButtonActionStudent();
                            }
                          }),
                          spaceHeightNormal
                        ],
                      ),
                    ),
                  ),
                  bottom: TabBar(
                    controller: controller.tabController,
                    dividerColor: AppColor.background,
                    indicatorColor: AppColor.blue300,
                    labelColor: AppColor.blue300,
                    unselectedLabelColor: AppColor.black,
                    labelStyle: AppTextStyle.tsSmallBold(AppColor.white),
                    tabs: [
                      Tab(text: 'Beranda'),
                      Tab(text: 'Tugas'),
                      Tab(text: 'Gallery'),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: controller.tabController,
            children: [
              Builder(
                builder: (BuildContext context) {
                  return CustomScrollView(
                    slivers: [
                      SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                      ),
                      SliverFillRemaining(
                        child: ContentBeranda(),
                      ),
                    ],
                  );
                },
              ),
              Builder(
                builder: (BuildContext context) {
                  return CustomScrollView(
                    slivers: [
                      SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                      ),
                      SliverFillRemaining(
                        child: ContentAssignment(),
                      ),
                    ],
                  );
                },
              ),
              Builder(
                builder: (BuildContext context) {
                  return CustomScrollView(
                    slivers: [
                      SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                      ),
                      SliverFillRemaining(
                        child: ContentAlbum(),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
