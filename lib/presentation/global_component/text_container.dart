import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../infrastructure/theme/theme.dart';

class TextContainer extends StatelessWidget {
  final Color color;
  final String text;
  final IconData? icon;
  final Color? colorText;

  const TextContainer({
    super.key,
    required this.color,
    required this.text,
    this.icon,
    this.colorText
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: AppTextStyle.tsTextContainer.copyWith(color: colorText)
            ),
            Icon(icon)
          ],
        ),
      ),
    );
  }
}