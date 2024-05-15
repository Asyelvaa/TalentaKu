import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/global_component/text_background.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';
import 'header_content.dart';

class SlideInformation extends StatelessWidget {
  final String headerContent;
  final List<String> contentTitles;
  final String image;

  const SlideInformation({
    super.key,
    required this.headerContent,
    required this.image,
    required this.contentTitles,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          HeaderContent(
              text: headerContent, imagePath: image),
          Container(
            width: Get.width,
            height: 100,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: contentTitles.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Content(contentTitle: contentTitles[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Content extends StatelessWidget {
  final String contentTitle;

  const Content({
    super.key,
    required this.contentTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 90,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColor.blue600, width: 2)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                contentTitle,
                style: AppTextStyle.tsNormal
              ),
              GestureDetector(
                onTap: () {
                  
                },
                child: TextWithBackground(
                  colorBackground: AppColor.blue600,
                  text: "Check it",
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}