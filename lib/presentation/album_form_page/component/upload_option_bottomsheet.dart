import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/album_form_page/controllers/album_form.controller.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';

class ShowUploadOptionsBottomSheet extends GetView<AlbumFormController> {

  Widget build(BuildContext context) {
        return Container(
          height: heightScreen * 0.3,
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                'Pilih dari',
                style: AppTextStyle.tsTitle.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              defaultHeightSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildOption(Icons.camera_alt, 'Camera', () {
                  }),
                  _buildOption(Icons.photo_library, 'Gallery', () {
                    controller.pickMedia();
                  }),
                ],
              ),
              defaultHeightSpace,
              ElevatedButton(
                onPressed: () => {Get.back()},
                child: Text('Cancel', style: AppTextStyle.tsNormal.copyWith(color: AppColor.white),),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColor.blue600,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),  
              ),
            ],
          ),
        );
  }
  }

  Widget _buildOption(IconData icon, String text, VoidCallback onTap,) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: AppColor.grey,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Icon(icon, size: 30, color: AppColor.black),
                  Text(text, style: AppTextStyle.tsNormal),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }