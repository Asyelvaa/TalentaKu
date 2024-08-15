// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
// import 'package:flutter_talentaku/presentation/album_page/album_detail_page.screen.dart';
// import 'package:flutter_talentaku/presentation/class_detail_page/component/beranda/laporan_pembelajaran.dart';
// import 'package:flutter_talentaku/presentation/common_widget/text_background.dart';
// import 'package:get/get.dart';

// import '../../../infrastructure/theme/theme.dart';
// import '../../profile_user/controllers/profile_user.controller.dart';
// import '../controllers/class_detail.controller.dart';

// class HeaderClass extends GetView<ProfileUserController> {
//   const HeaderClass({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(ClassDetailController());
//     final String titleAppbar = controller.classItem['name'] ?? 'hai';
//     return Container(
//       height: heightScreen * 0.4,
//       width: widthScreen,
//       decoration: BoxDecoration(
//         color: AppColor.blue600,
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             spaceHeightSmall,
//             Text(
//               '${controller.classItem['name']}',
//               style: AppTextStyle.tsTitleBold(AppColor.white),
//             ),
//             spaceHeightSmall,
//             TextWithBackground(
//               colorBackground: AppColor.white,
//               text: 'Kelompok bermain ${controller.classItem['desc']}',
//             ),
//             spaceHeightSmall,
//             Obx(() {
//               if (controller.isLoading.value) {
//                 return Center(
//                   child: CircularProgressIndicator(
//                     color: AppColor.white,
//                   ),
//                 );
//               }
//               if (controller.classMembers.isEmpty) {
//                 return Center(
//                     child: Text(
//                   "Belum memiliki murid",
//                   style: AppTextStyle.tsSmallRegular(AppColor.white),
//                 ));
//               }
//               return Expanded(  
//                 child: ListView.builder(
//                   shrinkWrap: true,
//                   scrollDirection: Axis.horizontal,
//                   itemCount: controller.students.length,
//                   itemBuilder: (context, index) {
//                     final student = controller.students[index];
//                     final isSelected =
//                         controller.selectedStudents.contains(student);
//                     final storedImage = controller.image.value;
//                     return GestureDetector(
//                       onTap: () {
//                         controller.toggleSelection(student);

//                         Get.toNamed(Routes.PROFILE_USER, arguments: [
//                           controller.students[index],
//                           controller.classItem['id']
//                         ]);
//                       },
//                       child: Container(
//                         width: widthScreen * 0.2,
//                         child: Column(children: [
//                           CircleAvatar(
//                               radius: 30,
//                               backgroundColor: AppColor.white,
//                               child: student.photo != null
//                                   ? ClipOval(
//                                       child: Image.network(
//                                         student.photo!,
//                                         width: 30,
//                                         height: 30,
//                                         fit: BoxFit.cover,
//                                       ),
//                                     )
//                                   : AutoSizeText(
//                                       getInitials(student.name!),
//                                       style: AppTextStyle.tsBodyBold(
//                                           AppColor.black),
//                                       minFontSize: 12,
//                                     )),
//                           AutoSizeText(
//                             student.name!,
//                             style: AppTextStyle.tsSmallRegular(AppColor.white),
//                             minFontSize: 12,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ]),
//                       ),
//                     );
//                   },
//                 ),
//               );
//             }),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 40),
//               child: Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       showModalBottomSheet(
//                         context: context,
//                         shape: RoundedRectangleBorder(
//                           borderRadius:
//                               BorderRadius.vertical(top: Radius.circular(25.0)),
//                         ),
//                         builder: (BuildContext context) {
//                           return Container(
//                             decoration: BoxDecoration(
//                                 color: AppColor.white,
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(12),
//                                     topRight: Radius.circular(12))),
//                             padding: const EdgeInsets.all(16.0),
//                             height: heightScreen * 0.60,
//                             child: Column(
//                               children: [
//                                 Container(
//                                   height: 5,
//                                   width: 70,
//                                   decoration: BoxDecoration(
//                                       color: AppColor.grey,
//                                       borderRadius: BorderRadius.circular(5)),
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Image.asset(
//                                       "assets/images/logo_talentaku.png",
//                                       scale: 15,
//                                     ),
//                                     defaultWidthtSpace,
//                                     Text(
//                                       '${controller.classItem['name']}',
//                                       style: AppTextStyle.tsTitleBold(
//                                           AppColor.black),
//                                     ),
//                                   ],
//                                 ),
//                                 spaceHeightSmall,
//                                 Divider(
//                                   color: AppColor.grey,
//                                   height: 5,
//                                 ),
//                                 defaultHeightSpace,
//                                 GestureDetector(
//                                   onTap: () {
//                                     // Get.bottomSheet(
//                                     //  // EditClassBottomSheet(),
//                                     //   //isScrollControlled: true,
//                                     // );
//                                   },
//                                   child: Container(
//                                     height: heightScreen * 0.07,
//                                     width: widthScreen,
//                                     decoration: BoxDecoration(
//                                         color: AppColor.blue50,
//                                         borderRadius:
//                                             BorderRadius.circular(12)),
//                                     child: Row(
//                                       children: [
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(left: 30),
//                                           child: Icon(Icons.edit_notifications),
//                                         ),
//                                         SizedBox(width: widthScreen * 0.05),
//                                         Text(
//                                           "Edit Kelas",
//                                           style: AppTextStyle.tsBodyRegular(
//                                               AppColor.black),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 spaceHeightSmall,
//                                 Container(
//                                   height: heightScreen * 0.07,
//                                   width: widthScreen,
//                                   decoration: BoxDecoration(
//                                       color: AppColor.blue50,
//                                       borderRadius: BorderRadius.circular(12)),
//                                   child: Row(
//                                     children: [
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 30),
//                                         child: Icon(Icons.edit_notifications),
//                                       ),
//                                       SizedBox(width: widthScreen * 0.05),
//                                       Text(
//                                         "Unggah pengumunan",
//                                         style: AppTextStyle.tsBodyRegular(
//                                             AppColor.black),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                                 spaceHeightSmall,
//                                 Container(
//                                   height: heightScreen * 0.07,
//                                   width: widthScreen,
//                                   decoration: BoxDecoration(
//                                       color: AppColor.blue50,
//                                       borderRadius: BorderRadius.circular(12)),
//                                   child: Row(
//                                     children: [
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 30),
//                                         child: Icon(Icons.edit_notifications),
//                                       ),
//                                       SizedBox(width: widthScreen * 0.05),
//                                       Text(
//                                         "Unggah Tugas",
//                                         style: AppTextStyle.tsBodyRegular(
//                                             AppColor.black),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                                 spaceHeightSmall,
//                                 GestureDetector(
//                                   onTap: () {
//                                     Get.toNamed('/student-report-form',
//                                         arguments: {
//                                           "gradeId": controller.classItem["id"]
//                                               .toString()
//                                         });
//                                   },
//                                   child: Container(
//                                     height: heightScreen * 0.07,
//                                     width: widthScreen,
//                                     decoration: BoxDecoration(
//                                         color: AppColor.blue50,
//                                         borderRadius:
//                                             BorderRadius.circular(12)),
//                                     child: Row(
//                                       children: [
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(left: 30),
//                                           child: Icon(Icons.edit_notifications),
//                                         ),
//                                         SizedBox(width: widthScreen * 0.05),
//                                         Text(
//                                           "Buat Laporan",
//                                           style: AppTextStyle.tsBodyRegular(
//                                               AppColor.black),
//                                         )
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 spaceHeightSmall,
//                               ],
//                             ),
//                           );
//                         },
//                       );
//                     },
//                     child: Container(
//                       height: 50,
//                       width: 40,
//                       decoration: BoxDecoration(
//                         color: AppColor.blue100,
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Icon(Icons.more_vert_outlined),
//                     ),
//                   ),
//                   LaporanPembelajaran(text: "Laporan ", imageName: "kid.png"),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// String getInitials(String name) {
//   List<String> nameParts = name.split(' ');
//   if (nameParts.length == 1) {
//     return nameParts[0].substring(0, 2).toUpperCase();
//   } else {
//     return (nameParts[0][0] + nameParts[1][0]).toUpperCase();
//   }
// }
