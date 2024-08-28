import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:core';

import '../../../infrastructure/theme/theme.dart';
import '../../common_widget/text_background.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: Get.width,
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColor.white,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  titleInfo,
                  style: AppTextStyle.tsTitle,
                ),
                TextWithBackground(
                  colorBackground: AppColor.blue100,
                  text: dateInfo,
                )
              ],
            ),
            Container(
              width: Get.width,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 1,
                itemBuilder: (context, index) {
                  return InformationListItem(
                      titleInfo: titleInfo, dateInfo: dateInfo);
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
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            child: const Icon(Icons.report),
            backgroundColor: Colors.blue.shade300,
            radius: 18,
          ),
          const SizedBox(width: 8), // Replace defaultWidthtSpace with SizedBox
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titleInfo, style: TextStyle(fontSize: 16)),
              Text(
                dateInfo,
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CurrentDateTimeWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd MMMM yyyy').format(DateTime.now());
    return InformationListItem(
      titleInfo: "Laporan harian Dimas",
      dateInfo: formattedDate,
    );
  }
}
