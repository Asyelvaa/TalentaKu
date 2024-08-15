import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_talentaku/presentation/class_detail_page/controllers/class_detail.controller.dart';
import 'package:get/get.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';

import '../../../../domain/models/class_model.dart';
import '../../../common_widget/custom_popup_dialog.dart';
import '../../../common_widget/text_background.dart';
import 'profile_name_avatar.dart';

class EditClassBottomSheet extends GetView<ClassDetailController> {
  const EditClassBottomSheet({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final grade = controller.dataClass.value;
    return DraggableScrollableSheet(
      initialChildSize: 0.8,
      expand: false,
      builder: (context, scrollController) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          color: AppColor.white,
        ),
        child: Column(
          children: [
            // HEADER
            Container(
              width: widthScreen * 0.1,
              height: heightScreen * 0.005,
              decoration: BoxDecoration(
                borderRadius: defaultBorderRadius,
                color: AppColor.black.withOpacity(0.1),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: heightScreen * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImage.logoTalentaku,
                    scale: 15,
                  ),
                  defaultWidthtSpace,
                  Text(
                    'Pengaturan Kelas',
                    style: AppTextStyle.tsTitleBold(AppColor.black),
                  ),
                ],
              ),
            ),
            // BODY

            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text('Kode Kelas',
                                      style: AppTextStyle.tsBodyBold(
                                          AppColor.black))),
                              TextWithBackground(
                                colorBackground: AppColor.blue100,
                                text: controller.dataClass.value.uniqueCode! ??
                                    '',
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Clipboard.setData(
                                      ClipboardData(text: grade.uniqueCode!));
                                  Get.snackbar(
                                    'Salin Kode',
                                    'Kode Kelas berhasil di salin',
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: AppColor.blue100,
                                  );
                                },
                                child: Icon(
                                  Icons.copy_rounded,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          spaceHeightSmall,
                          Text('Nama Kelas',
                              style: AppTextStyle.tsBodyBold(AppColor.black)),
                          TextField(
                            controller: controller.classNameController,
                            decoration: InputDecoration(
                              hintText: grade.name,
                              hintStyle: AppTextStyle.tsNormal,
                              suffixIcon: Icon(Icons.edit),
                              suffixIconColor: AppColor.blue600,
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColor.blue200),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.blue600, width: 1),
                              ),
                            ),
                          ),
                          spaceHeightSmall,
                          Text('Deskripsi Kelas',
                              style: AppTextStyle.tsBodyBold(AppColor.black)),
                          TextField(
                            controller: controller.classDescController,
                            decoration: InputDecoration(
                              hintText: grade.desc,
                              hintStyle: AppTextStyle.tsNormal,
                              suffixIcon: Icon(Icons.edit),
                              suffixIconColor: AppColor.blue600,
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColor.blue200),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.blue600, width: 1),
                              ),
                            ),
                          ),
                          spaceHeightSmall,
                          Text('Level Kelas',
                              style: AppTextStyle.tsBodyBold(AppColor.black)),
                          TextField(
                            controller: controller.classLevelController,
                            decoration: InputDecoration(
                              hintText: grade.levelName,
                              hintStyle: AppTextStyle.tsNormal,
                              suffixIcon: Icon(Icons.edit),
                              suffixIconColor: AppColor.blue600,
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: AppColor.blue200),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColor.blue600, width: 1),
                              ),
                            ),
                          ),
                          spaceHeightSmall,
                          Row(
                            children: [
                              Text('Guru Kelas : ',
                                  style:
                                      AppTextStyle.tsBodyBold(AppColor.black)),
                              Text('${grade.teacher!}',
                                  style: AppTextStyle.tsBodyRegular(
                                      AppColor.black)),
                            ],
                          ),
                          spaceHeightSmall,
                          Text('Anggota Kelas',
                              style: AppTextStyle.tsBodyBold(AppColor.black)),
                          grade.member == null || grade.member!.isEmpty
                              ? Text('Belum ada siswa yang bergabung',
                                  style: AppTextStyle.tsBodyRegular(AppColor.black))
                              : ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: grade.member!.length,
                                  itemBuilder: (context, index) {
                                    final member = grade.member![index];
                                    return ListTile(
                                      title: Text(
                                        member.name!,
                                        style: AppTextStyle.tsBodyRegular(
                                            AppColor.black),
                                      ),
                                      leading: CircleAvatar(
                                        backgroundColor: AppColor.blue100,
                                        child: Text(member.name![0]),
                                      ),
                                      trailing: IconButton(
                                        icon: Icon(Icons.remove_circle_sharp),
                                        onPressed: () {
                                          showCustomPopupDialog(
                                            'Konfirmasi',
                                            'Apakah Anda yakin ingin menghapus anggota ini dari kelas?',
                                            [
                                              TextButton(
                                                onPressed: () => Get.back(),
                                                child: Text(
                                                  'Tidak',
                                                  style: AppTextStyle
                                                      .tsBodyRegular(
                                                          AppColor.black),
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                  controller.removeMember(
                                                      member.id!.toString());
                                                },
                                                child: Text(
                                                  'Iya, Hapus',
                                                  style: AppTextStyle
                                                      .tsBodyRegular(
                                                          AppColor.red),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Active Class',
                                  style:
                                      AppTextStyle.tsBodyBold(AppColor.black)),
                              Obx(
                                () => Switch(
                                  activeColor: AppColor.blue600,
                                  value: controller
                                          .dataClass.value.isActiveStatus ==
                                      'active',
                                  onChanged: (value) {
                                    showCustomPopupDialog(
                                      'Konfirmasi',
                                      'Apakah Anda yakin ingin ${value ? 'mengaktifkan' : 'menonaktifkan'} kelas ini?',
                                      [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor: AppColor.white),
                                          onPressed: () => Get.back(),
                                          child: Text(
                                            'Tidak',
                                            style: AppTextStyle.tsBodyRegular(
                                                AppColor.black),
                                          ),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              elevation: 0,
                                              backgroundColor:
                                                  AppColor.blue600),
                                          onPressed: () {
                                            Get.back();
                                            controller
                                                .toggleActiveStatus(value);
                                          },
                                          child: Text(
                                            ' ${value ? 'Aktifkan' : 'Nonaktifkan'}',
                                            style: AppTextStyle.tsBodyRegular(
                                                AppColor.white),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          spaceHeightNormal,
                          ElevatedButton(
                            onPressed: () {
                              showCustomPopupDialog(
                                'Peringatan!',
                                'Apakah Anda yakin ingin menghapus kelas ini?',
                                [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: AppColor.white),
                                    onPressed: () => Get.back(),
                                    child: Text(
                                      'Tidak',
                                      style: AppTextStyle.tsBodyRegular(
                                          AppColor.black),
                                    ),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        elevation: 0,
                                        backgroundColor: AppColor.blue600),
                                    onPressed: () {
                                      Get.back();
                                      controller.deleteClass();
                                    },
                                    child: Text(
                                      'Hapus Kelas',
                                      style: AppTextStyle.tsBodyRegular(
                                          AppColor.white),
                                    ),
                                  ),
                                ],
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Hapus Kelas',style: AppTextStyle.tsBodyBold( AppColor.black)),
                                Icon(Icons.delete_forever, color: AppColor.red),
                              ],
                            ),
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.all(12),
                                backgroundColor: AppColor.grey,
                                shape: RoundedRectangleBorder(borderRadius: defaultBorderRadius),
                                elevation: 0
                                ),
                          )
                        ],
                      ),
                    ),
                    // BOTTOM ACTION SECTION
                  ],
                ),
              ),
            ),
            // BOTTOM
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: Text('Kembali',
                      style: AppTextStyle.tsBodyBold(AppColor.black)),
                ),
                ElevatedButton(
                  onPressed: () {
                    showCustomPopupDialog(
                      'Konfirmasi',
                      'Apakah Anda yakin ingin menyimpan perubahan?',
                      [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0, backgroundColor: AppColor.white),
                          onPressed: () => Get.back(),
                          child: Text(
                            'Tidak',
                            style: AppTextStyle.tsBodyRegular(AppColor.black),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0, backgroundColor: AppColor.blue600),
                          onPressed: () {
                            Get.back();
                            controller.updateGradeDetails();
                          },
                          child: Text(
                            'Iya, Simpan',
                            style: AppTextStyle.tsBodyRegular(AppColor.white),
                          ),
                        ),
                      ],
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.blue600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0),
                  child: Text('Simpan',
                      style: AppTextStyle.tsNormal.copyWith(
                          fontWeight: FontWeight.bold, color: AppColor.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
