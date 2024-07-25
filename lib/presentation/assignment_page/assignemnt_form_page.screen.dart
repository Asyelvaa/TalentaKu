import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/screens.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../infrastructure/theme/theme.dart';
import '../global_component/back_appbar.dart';
import 'component/circular_icon_button.dart';
import 'controllers/assignment_page.controller.dart';

class AssignemntFormPageScreen extends StatelessWidget {
  AssignemntFormPageScreen({Key? key}) : super(key: key);

  final AssignmentPageController controller = Get.put(AssignmentPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: BackAppbar(titleAppbar: 'Buat Tugas')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextFormField(
                  controller: controller.titleController,
                  decoration: InputDecoration(
                    hintText: 'Tambahkan Judul...',
                    hintStyle: AppTextStyle.tsLittle,
                    labelText: 'Judul',
                    fillColor: AppColor.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: AppColor.blue500),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: AppColor.blue500),
                    ),
                  ),
                  maxLines: null,
                  minLines: 1,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: controller.descController,
                  decoration: InputDecoration(
                    hintText: 'Tambahkan deskripsi...',
                    hintStyle: AppTextStyle.tsLittle,
                    labelText: 'Deskripsi',
                    fillColor: AppColor.white,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: AppColor.blue500),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: AppColor.blue500),
                    ),
                  ),
                  maxLines: null,
                  minLines: 1,
                ),
                SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      Text('Tenggat :', style: AppTextStyle.tsNormal,),
                      IconButton(
                        onPressed: () => controller.pickDate(context),
                        icon: Icon(Icons.calendar_today),
                      ),
                      Obx(() {
                        return Text(
                          controller.selectedDate.value != null
                              ? '${controller.selectedDate.value!.day}/${controller.selectedDate.value!.month}/${controller.selectedDate.value!.year}'
                              : 'No date selected',
                          style: AppTextStyle.tsNormal,
                        );
                      }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Row(
                    children: [
                      CircularIconButton(
                        icon: Icons.file_upload, 
                        onPressed: () => controller.pickMedia(ImageSource.gallery)
                      ),
                      SizedBox(width: 8),
                      CircularIconButton(
                        icon: Icons.link_rounded, 
                        onPressed: () => controller.addLink()
                      )
                    ],
                  ),
                ),
                Obx(() {
                  if (controller.isLinkInputVisible.value) {
                    return Column(
                      children: [
                        TextField(
                          controller: controller.linkController,
                          decoration: InputDecoration(
                            labelText: 'Masukkan link',
                            suffixIcon: IconButton(
                              icon: Icon(Icons.check),
                              onPressed: () => controller.submitLink(),
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return SizedBox.shrink();
                }),
                Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: controller.links
                    .map((link) => Text(link, overflow: TextOverflow.ellipsis,))
                    .toList(),
                )),
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.start ,
                  children: controller.selectedFiles
                      .map((file) => Image.file(File(file.path), width: 60, height: 80, fit: BoxFit.cover))
                      // .map((file) => Text(file.path.split('/').last))
                      .toList(),
                )),
                defaultHeightSpace,
                ElevatedButton(
                    onPressed: () async {
                      await controller.createTask();
                      Get.back();
                      
                    }, 
                    child: Center(
                      child: Text(
                        'Kirim Tugas',
                        style: AppTextStyle.tsNormal,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromHeight(50),
                      backgroundColor: AppColor.blue100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ElevatedButton(onPressed: () {Get.to(AssignmentPageScreen());}, child: Text('Assignment Page View')),  
              ],
            ),
          ),
        ));
  }
}
