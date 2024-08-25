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
        padding: EdgeInsets.all(20),
        width: Get.width * 0.9,
        height: Get.height * 0.6,
        decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                style: AppTextStyle.tsTitleBold(AppColor.black),
              ),
            ),
            spaceHeightNormal,
            Container(
              height: 2,
              width: 250,
              color: AppColor.black,
            ),
            spaceHeightLarge,
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
                                  style: AppTextStyle.tsBodyBold(AppColor.black),
                                ),
                                spaceHeightExtraSmall,
                                ...content.desc
                                    .map((desc) => Padding(padding:EdgeInsets.symmetric(vertical: 2),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(width: 10),
                                              Text(
                                                "-",
                                                style: AppTextStyle.tsBodyRegular(AppColor.black)
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  desc,
                                                  style: AppTextStyle.tsBodyRegular(AppColor.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ))
                                    .toList(),
                                spaceHeightNormal,
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
