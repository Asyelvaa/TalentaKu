import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readmore/readmore.dart';

import '../../../infrastructure/theme/theme.dart';
import '../model/post_card_model.dart';

class PostCard extends StatelessWidget {
  final PostCardModel postCardModel;

  PostCard({super.key, required this.postCardModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  postCardModel.title,
                  style: AppTextStyle.tsNormal,
                ),
                Text(
                  postCardModel.datePost,
                  style: AppTextStyle.tsLittle,
                ),
              ],
            ),
            // Save Button
            InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 32,
                  width: 70,
                  decoration: BoxDecoration(
                    color: AppColor.blue600,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text("Simpan",
                        style: AppTextStyle.tsNormal
                            .copyWith(color: AppColor.white)),
                  ),
                ))
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 15),
          height: heightScreen * 0.4,
          width: Get.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/mobil.png"),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ReadMoreText(
            postCardModel.description,
            trimMode: TrimMode.Line,
            trimLines: 2,
            colorClickableText: Colors.grey,
            trimCollapsedText: ' more',
            trimExpandedText: ' less',
          ),
        ),
        SizedBox(height: 15)
      ],
    );
  }
}
