import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../infrastructure/theme/theme.dart';
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
        padding: EdgeInsets.all(16),
        width: Get.width * 0.8,
        height: Get.height * 0.6,
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.all(Radius.circular(12))),
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
              information.informationTitle,
              style: AppTextStyle.tsTitle.copyWith(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 2,
              width: 250,
              color: AppColor.black,
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: information.informationData
                      .map((content) => Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(content.title,
                                    style: AppTextStyle.tsNormal),
                                SizedBox(height: 4),
                                ...content.desc
                                    .map((desc) => Text(desc,
                                        style: AppTextStyle.tsLittle))
                                    .toList(),
                              ],
                            ),
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
