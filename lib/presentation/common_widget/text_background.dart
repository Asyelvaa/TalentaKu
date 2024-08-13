import 'package:flutter/material.dart';

import '../../infrastructure/theme/theme.dart';

class TextWithBackground extends StatelessWidget {
  final Color colorBackground;
  final String text;
  
  const TextWithBackground({
    super.key,
    required this.colorBackground,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: widthScreen * 0.02, vertical: heightScreen * 0.01),
        decoration: BoxDecoration(
          color: colorBackground,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(text,
            style: AppTextStyle.tsSmallRegular(AppColor.black)));
  }
}
