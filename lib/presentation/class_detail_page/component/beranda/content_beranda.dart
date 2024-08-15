import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../controllers/class_detail.controller.dart';
import 'widget_announcement_bottomsheet.dart';
import 'widget_announcement_display.dart';
import 'widget_announcement_task_display.dart';
import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/controllers/class_detail.controller.dart';
import 'package:get/get.dart';

import '../../../../infrastructure/theme/theme.dart';
import '../../../common_widget/custom_button_icon.dart';

class ContentBeranda extends GetView<ClassDetailController> {
  const ContentBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClassDetailController());

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Obx((){
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else if (controller.albums.isEmpty) {
              return Center(child: Container(
                padding: EdgeInsets.all(20),
                child: Text('Belum ada pengumuman', style: AppTextStyle.tsBodyRegular(AppColor.black),),),);
            } else {
              return  ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  // ...controller.albums.map((album) => CustomWidgetAnnouncementDisplay(announcement: album)).toList(),
                ],
              );
            }})
            // Obx(() {
            //   var roles = controller.userRole;
            //   if (controller.isLoading.value){
            //     return Center(child: CircularProgressIndicator(),);
            //   }
            //   else if (roles != null && roles.any((role) => role.contains('Murid'))) {
            //     return CustomButtonWithIcon(
            //       text: "Laporan Pembelajaran",
            //       icon: Icons.arrow_forward_rounded,
            //       colorButton: AppColor.white,
            //       colorIcon: AppColor.black,
            //       colorText: AppColor.black,
            //       onPressed: () {
            //         var classItemId = controller.classItem["id"].toString();
            //         Get.toNamed(Routes.REPORT_LIST_PAGE, arguments: {
            //           "gradeId": classItemId
            //         });
            //       },
            //     );
            //   } else {
            //     return Container();
            //   }
            // }),
          ],
        ),
      ),
    );
  }
}
    // return CustomScrollView(
    //   slivers: [ 
    //     SliverToBoxAdapter(
    //       child: Obx(() {
    //           var roles = controller.userRole;
    //           if (roles != null && roles.any((role) => role.contains('Murid'))) {
    //             return CustomButtonWithIcon(
    //               text: "Laporan Pembelajaran",
    //               icon: Icons.arrow_forward_rounded,
    //               colorButton: AppColor.white,
    //               colorIcon: AppColor.black,
    //               colorText: AppColor.black,
    //               onPressed: () {
    //                 Get.toNamed(Routes.REPORT_LIST_PAGE, arguments: {
    //                   "gradeId": controller.classItem["id"].toString()
    //                 });
    //               },
    //             );
    //           } else {
    //             return Container();
    //           }
    //         }),
    //     ),
    //     SliverToBoxAdapter(
    //       child: Padding(
    //         padding: EdgeInsets.all(20),
    //         child: Column(
    //           children: [                
    //             Obx(() {
    //               var roles = controller.userRole;
    //               if (controller.isLoading.value) {
    //                 return Center(child: CircularProgressIndicator());
    //               } else if (roles.any((role) => role.contains('Guru KB'))) 
    //               { return GestureDetector(
    //                 onTap: () => (Get.bottomSheet(CustomWidgetAnnouncementBottomsheet(), isScrollControlled: true)),
    //                 child: Padding(
    //                   padding: const EdgeInsets.only(bottom: 8.0),
    //                   child: Container(
    //                     alignment: Alignment.center,
    //                     height: 40,
    //                     decoration: BoxDecoration(
    //                       borderRadius: BorderRadius.circular(12),
    //                       color: AppColor.blue100,
    //                     ),
    //                     child: Text(
    //                       'Buat Pengumuman Kelas',
    //                       style: AppTextStyle.tsSmallBold(AppColor.black)),
    //                   ),
    //                 ),
    //               );
    //               } else {
    //                 return Container();
    //               }
    //             }),            
    //           ],
    //         ),
    //       ),
    //     ),
    //     Obx(() {
    //       if (controller.isLoading.value) {
    //         return SliverToBoxAdapter(
    //           child: Center(child: CircularProgressIndicator()),
    //         );
    //       } else {
    //         return SliverList(
    //           delegate: SliverChildBuilderDelegate(
    //             (context, index) {
    //               final content = controller.classStream[index];
    //               if (content['type'] == 'task') {
    //                 return CustomWidgetAnnouncementTaskDisplay(task: content);
    //               } else if (content['type'] == 'comment') {
    //                 return CustomWidgetAnnouncementDisplay(announcement: content);
    //               } else {
    //                 return Container(); 
    //               }
    //             },
    //             childCount: controller.classStream.length,
    //           ),
    //         );
    //       }
    //     })
    //   ]
    // );
//   }
// }

// child: Padding(
      //   padding: const EdgeInsets.all(20),
      //   child: Column(
      //     children: [
      //       Task(title: "Tugas baru : Matematika Dasar", date: "Feb 02, 2024"),
      //           Container(
      //             margin: EdgeInsets.only(top: 12),
      //             decoration: BoxDecoration(
      //                 borderRadius: BorderRadius.circular(20),
      //                 color: AppColor.white,
      //                 boxShadow: [
      //                   BoxShadow(
      //                     color: Colors.grey.withOpacity(0.2),
      //                     blurRadius: 2,
      //                     offset: Offset(0, 1),
      //                   )
      //                 ]
      //             ),
      //             width: 320,
      //             height: 300,
      //             child: Column(
      //               children: [
      //                 Row(
      //                   children: [
      //                     Padding(
      //                         padding: const EdgeInsets.only(left: 20, top: 25),
      //                         child: CircleAvatar(
      //                           child: Image.asset("assets/images/student.png"),
      //                           radius: 16,
      //                         )),
      //                     Column(
      //                       children: [
      //                         Padding(
      //                           padding: EdgeInsets.only(right: 30, top: 20),
      //                           child: Text("Anita Fauza",
      //                               style: AppTextStyle.tsLittle),
      //                         ),
      //                         Padding(
      //                           padding: EdgeInsets.only(right: 40, left: 10),
      //                           child: Text(
      //                             "May 05 2024",
      //                             style: GoogleFonts.poppins(
      //                                 fontWeight: FontWeight.w400,
      //                                 fontSize: 11,
      //                                 color: Colors.black),
      //                           ),
      //                         ),
      //                       ],
      //                     )
      //                   ],
      //                 ),
      //                 Padding(
      //                   padding:
      //                       EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      //                   child: Text(
      //                       "Selamat Pagi\nBerikut adalah pemberitahuan mengenai Libur Lebaran"),
      //                 ),
      //                 Column(
      //                   children: [
      //                     Row(
      //                       children: [
      //                         Padding(
      //                             padding:
      //                                 const EdgeInsets.only(left: 20, top: 15),
      //                             child: Image.asset("assets/images/pdf.png")),
      //                         Column(
      //                           children: [
      //                             Padding(
      //                               padding: EdgeInsets.only(right: 25, top: 10),
      //                               child: Text("Pemberitahuan Libur Lebaran",
      //                                   style: GoogleFonts.poppins(
      //                                     fontWeight: FontWeight.w500,
      //                                     fontSize: 12,
      //                                   )),
      //                             ),
      //                             Padding(
      //                               padding:
      //                                   EdgeInsets.only(right: 200, left: 10),
      //                               child: Text(
      //                                 "PDF",
      //                                 style: GoogleFonts.poppins(
      //                                     fontWeight: FontWeight.w500,
      //                                     fontSize: 12,
      //                                     color: AppColor.grey),
      //                               ),
      //                             ),
      //                           ],
      //                         )
      //                       ],
      //                     ),
      //                     SizedBox(height: 10),
      //                     Container(
      //                       height: 1,
      //                       width: 280,
      //                       decoration: BoxDecoration(color: AppColor.black),
      //                     ),
      //                     Container(
      //                       child: Row(
      //                         children: [
      //                           Padding(
      //                             padding: EdgeInsets.all(20),
      //                             child: CircleAvatar(
      //                               child: Image.asset("assets/images/photo.png"),
      //                               radius: 20,
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ),
      //                   ],
      //                 )
      //               ],
      //             ),
      //           )
      //     ],
      //   ),
      // ),

// Obx(() {
//               if (controller.isLoading.value) {
//                 return Center(child: CircularProgressIndicator());
//               }
//               else if (controller.dataClass.value.isActiveStatus! == 'inactive') {
//               return 
//                 Padding(
//                   padding: const EdgeInsets.all(20),
//                   child: Container(
//                     padding: EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: AppColor.red,
//                       borderRadius: defaultBorderRadius
//                     ),
//                     child: Text(
//                       'Class has been archived by your teacher. You can’t add or edit anything',
//                       style: AppTextStyle.tsSmallBold(AppColor.white),
//                     ),
//                   ),
//                 );
//               } else {
//                 return Container();
//               }           
//             }
//             ),
