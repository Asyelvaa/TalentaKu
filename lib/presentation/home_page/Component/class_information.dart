import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';
import '../../global_component/text_background.dart';

class ClassInformation extends StatelessWidget {
  final String titleInfo;
  final String dateInfo;

  const ClassInformation({
    super.key,
    required this.titleInfo,
    required this.dateInfo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        width: Get.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColor.white,
        ),
        child: Column(
          children: [
            // INFORMATION HEADER
            Row(
              children: [
                Text(
                  "Informasi",
                  style: AppTextStyle.tsTitle,
                ),
                TextWithBackground(
                  colorBackground: AppColor.blue300,
                  text: "Senin, 04/04/2024",
                )
              ],
            ),
            // INFORMATION CONTENT
            Container(
              width: Get.width,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 2,
                itemBuilder: (context, index) {
                  return InformationListItem(titleInfo: titleInfo, dateInfo: dateInfo);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class InformationListItem extends StatelessWidget {
  const InformationListItem({
    super.key,
    required this.titleInfo,
    required this.dateInfo,
  });

  final String titleInfo;
  final String dateInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColor.grey,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            child: Icon(Icons.report),
            backgroundColor: AppColor.blue300,
            radius: 50,
          ),
          Column(
            children: [
              Text(titleInfo, style: AppTextStyle.tsNormal),
              Text(
                dateInfo,
                style: AppTextStyle.tsNormal,
              ),
            ],
          )
        ],
      ),
    );
  }
}
