import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/class_page/controllers/class_page.controller.dart';
import 'package:get/get.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';

import '../../../domain/models/class_model.dart';
import 'profile_name_avatar.dart';

class EditClassBottomSheet extends GetView<ClassController> {
  const EditClassBottomSheet({
    Key? key, 
    required this.grade
    }) : super(key: key);
  final GradeModel grade;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nama Kelas: ${grade.name}', style: AppTextStyle.tsNormal),
          SizedBox(height: 8),
          Text('Kode Kelas: ${grade.uniqueCode}', style: AppTextStyle.tsNormal),
          SizedBox(height: 8),
          Text('Deskripsi: ${grade.desc}', style: AppTextStyle.tsNormal),
          SizedBox(height: 8),
          Text('Level: ${grade.level}', style: AppTextStyle.tsNormal),
          SizedBox(height: 8),
          Text('Pengajar: ${grade.teacherId}', style: AppTextStyle.tsNormal),
          SizedBox(height: 8),
          Text('Status Aktif: ${grade.isactive}', style: AppTextStyle.tsNormal),
          SizedBox(height: 16),
          Text('Anggota Kelas:', style: AppTextStyle.tsNormal),
          ListView.builder(
            shrinkWrap: true,
            itemCount: grade.member.length,
            itemBuilder: (context, index) {
              final member = grade.member[index];
              return ProfileNameAvatar(
                name: member.name,
                profile: member.photo,
              );
            },
          ),
        ],
      ),
    );
    // return Container(
    //   padding: EdgeInsets.all(20),
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    //     color: AppColor.white,
    //   ),
    //   child: SingleChildScrollView(
    //     child: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       children: [
    //         Container(
    //           width: 40,
    //           height: 5,
    //           decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(10),
    //             color: Colors.grey[300],
    //           ),
    //         ),
    //         Padding(
    //           padding: const EdgeInsets.all(12),
    //           child: Text(
    //             'Pengaturan Kelas',
    //             style: AppTextStyle.tsTitle.copyWith(fontSize: 20),
    //           ),
    //         ),
    //         // Class Code Section
    //         Padding(
    //           padding: const EdgeInsets.symmetric(vertical: 12),
    //           child: Row(
    //             children: [
    //               Text('Kode Kelas', style: AppTextStyle.tsNormal),
    //               Spacer(),
    //               Text('098UYT4D', style: AppTextStyle.tsNormal),
    //               IconButton(
    //                 icon: Icon(Icons.copy, color: AppColor.black),
    //                 onPressed: () {
    //                   // Copy to clipboard functionality
    //                 },
    //               )
    //             ],
    //           ),
    //         ),
    //         // Class Name Section
    //         Padding(
    //           padding: const EdgeInsets.symmetric(vertical: 12),
    //           child: TextField(
    //             controller: controller.classNameController,
    //             decoration: InputDecoration(
    //               hintText: 'Nama Kelas',
    //               hintStyle: AppTextStyle.tsNormal,
    //               border: UnderlineInputBorder(
    //                 borderSide: BorderSide(color: AppColor.blue200),
    //               ),
    //               focusedBorder: UnderlineInputBorder(
    //                 borderSide: BorderSide(color: AppColor.blue600, width: 2.0),
    //               ),
    //               contentPadding: EdgeInsets.all(8),
    //             ),
    //           ),
    //         ),
    //         // Class Description Section
    //         Padding(
    //           padding: const EdgeInsets.symmetric(vertical: 12),
    //           child: TextField(
    //             controller: controller.classDescController,
    //             decoration: InputDecoration(
    //               hintText: 'Deskripsi Kelas',
    //               hintStyle: AppTextStyle.tsNormal,
    //               border: UnderlineInputBorder(
    //                 borderSide: BorderSide(color: AppColor.blue200),
    //               ),
    //               focusedBorder: UnderlineInputBorder(
    //                 borderSide: BorderSide(color: AppColor.blue600, width: 2.0),
    //               ),
    //               contentPadding: EdgeInsets.all(8),
    //             ),
    //           ),
    //         ),
    //         // Class Members Section
    //         Padding(
    //           padding: const EdgeInsets.symmetric(vertical: 12),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text('Anggota Kelas', style: AppTextStyle.tsNormal),
    //               SizedBox(height: 10),
    //               // Add List of Members here
    //               for (var member in controller.classMembers)
    //                 ListTile(
    //                   leading: CircleAvatar(
    //                     backgroundImage: NetworkImage(member.avatarUrl),
    //                   ),
    //                   title: Text(member.name, style: AppTextStyle.tsNormal),
    //                 ),
    //             ],
    //           ),
    //         ),
    //         // Archive Class Section
    //         Padding(
    //           padding: const EdgeInsets.symmetric(vertical: 12),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               Text('Archive Class', style: AppTextStyle.tsNormal),
    //               Switch(
    //                 value: controller.isArchived.value,
    //                 onChanged: (value) {
    //                   controller.isArchived.value = value;
    //                 },
    //               ),
    //             ],
    //           ),
    //         ),
    //         // Bottom Action Buttons
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           children: [
    //             ElevatedButton(
    //               onPressed: () {
    //                 Get.back();
    //               },
    //               style: ElevatedButton.styleFrom(
    //                 backgroundColor: AppColor.white,
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(10),
    //                 ),
    //                 elevation: 0,
    //               ),
    //               child: Text(
    //                 'Batalkan',
    //                 style: AppTextStyle.tsNormal.copyWith(
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ),
    //             ),
    //             ElevatedButton(
    //               onPressed: () {
    //                 controller.editClass({
    //                   'name': controller.classNameController.text,
    //                   'desc': controller.classDescController.text,
    //                   'is_archived': controller.isArchived.value,
    //                 });
    //                 Get.back();
    //               },
    //               style: ElevatedButton.styleFrom(
    //                 backgroundColor: AppColor.blue600,
    //                 shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(10),
    //                 ),
    //                 elevation: 0,
    //               ),
    //               child: Text(
    //                 'Simpan',
    //                 style: AppTextStyle.tsNormal.copyWith(
    //                   fontWeight: FontWeight.bold,
    //                   color: AppColor.white,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
