import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:get/get.dart';

import '../models/information_data.dart';

class HomePopupInformation extends StatelessWidget {
  final Information information;

  const HomePopupInformation({super.key, required this.information});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        width: widthScreen * 0.8,
        height: heightScreen * 0.8,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(Icons.close),
              ),
            ),
            Text(
              information.title,
              style: AppTextStyle.tsTitle.copyWith(fontSize: 20),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: information.contents.map((content) => Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          content.title,
                          style: AppTextStyle.tsNormal
                        ),
                        SizedBox(height: 4),
                        ...content.description.map((desc) => Text(desc, style: AppTextStyle.tsLittle)).toList(),
                      ],
                    ),
                  )).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
