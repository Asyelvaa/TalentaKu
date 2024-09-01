import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../common_widget/custom_popup_dialog.dart';
import '../../controllers/class_detail.controller.dart';
import 'pdf_widget.dart';

class AnnouncementComponent extends GetView<ClassDetailController> {
  const AnnouncementComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ClassDetailController());

    return SizedBox(
      width: Get.width,
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.announcementsList.isEmpty) {
          return Center(
            child: Text(
              "Belum ada pengumuman kelas",
              style: AppTextStyle.tsBodyRegular(AppColor.black),
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.announcementsList.length,
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var announcement = controller.announcementsList[index];
            return _buildAnnouncementCard(context, announcement);
          },
        );
      }),
    );
  }

  Widget _buildAnnouncementCard(BuildContext context, Map<String, dynamic> announcement) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context, announcement),
          const SizedBox(height: 8),
          _buildAnnouncementText(announcement),
          const SizedBox(height: 8),
          _buildMediaContent(announcement),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Map<String, dynamic> announcement) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColor.blue500,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  announcement['user']['name'],
                  style: AppTextStyle.tsBodyBold(AppColor.black),
                ),
                Text(
                  DateFormat('dd MMMM yyyy', 'id_ID').format(
                    DateTime.parse(announcement['created_at'].toString()),
                  ),
                  style: AppTextStyle.tsSmallRegular(AppColor.black),
                ),
              ],
            ),
          ],
        ),
        PopupMenuButton<int>(
          icon: Icon(Icons.more_vert, color: AppColor.black),
          onSelected: (value) {
            if (value == 1) {
              showDeleteConfirmationDialog(context, announcement['id'].toString());
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Row(
                children: [
                  Icon(Icons.delete_forever, color: AppColor.red),
                  const SizedBox(width: 8),
                  Text(
                    'Hapus Pengumuman',
                    style: AppTextStyle.tsSmallRegular(AppColor.black),
                  ),
                ],
              ),
            ),
          ],
          color: AppColor.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ],
    );
  }

  Widget _buildAnnouncementText(Map<String, dynamic> announcement) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: announcement['announcements'].map<Widget>((announcment) {
        return Text(
          announcment ?? '',
          style: AppTextStyle.tsBodyRegular(AppColor.black),
        );
      }).toList(),
    );
  }

  Widget _buildMediaContent(Map<String, dynamic> announcement) {
    if (announcement['media'].isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: announcement['media'].map<Widget>((media) {
        String fileName = media['file_name'];
        String fileExtension = fileName.split('.').last.toLowerCase();
        String fileUrl = 'https://talentaku.site/image/announcement-media/$fileName';

        if (['jpg', 'jpeg', 'png'].contains(fileExtension)) {
          return Container(
            height: Get.height * 0.2,
            padding: const EdgeInsets.only(top: 8.0),
            child: Image.network(
              fileUrl,
              fit: BoxFit.scaleDown,
            ),
          );
        } else if (fileExtension == 'pdf') {
          return Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: PDFWidget(
              fileUrl: fileUrl,
              fileName: fileName,
            ),
          );
        } else {
          return const SizedBox(); // Handles unsupported file types
        }
      }).toList(),
    );
  }

  void showDeleteConfirmationDialog(BuildContext context, String announcementId) {
    showCustomPopupDialog(
      'Konfirmasi',
      'Apakah Anda yakin ingin menghapus anggota ini dari kelas?',
      [
        TextButton(
          onPressed: () => Get.back(),
          child: Text(
            'Tidak',
            style: AppTextStyle.tsBodyRegular(AppColor.black),
          ),
        ),
        TextButton(
          onPressed: () {
            Get.back();
            controller.deleteAnnouncement(announcementId);
          },
          child: Text(
            'Iya, Hapus',
            style: AppTextStyle.tsBodyRegular(AppColor.red),
          ),
        ),
      ],
    );
  }
}
