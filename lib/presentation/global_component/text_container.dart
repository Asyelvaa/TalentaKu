import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';

class TextWithContainer extends StatelessWidget {
  final Color colorContainer;
  final String text;
  final IconData? icon;
  final Color? colorText;

  const TextWithContainer(
      {super.key,
      required this.colorContainer,
      required this.text,
      this.icon,
      this.colorText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: colorContainer),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text, style: AppTextStyle.tsTitle.copyWith(color: colorText)),
            Icon(icon)
          ],
        ),
      ),
    );
  }
}
