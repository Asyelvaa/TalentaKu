import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../infrastructure/theme/theme.dart';
import '../models/information_data.dart';

class HomePopupRba extends StatelessWidget {
  final Information information;

  const HomePopupRba({Key? key, required this.information}) : super(key: key);

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
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Center(
              child: Text(
                information.informationTitle,
                style: AppTextStyle.tsTitle.copyWith(fontSize: 20),
              ),
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
                                Text(
                                  content.title,
                                  style: AppTextStyle.tsNormal,
                                ),
                                SizedBox(height: 4),
                                ...content.desc
                                    .map((desc) => Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 2),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(width: 10),
                                              Text(
                                                "-",
                                                style: AppTextStyle.tsLittle
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold),
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  desc,
                                                  style: AppTextStyle.tsLittle,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
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
