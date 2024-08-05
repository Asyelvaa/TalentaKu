import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';

class CustomButtonActionSecondary extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButtonActionSecondary({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.white,
        shape: RoundedRectangleBorder(
          borderRadius: defaultBorderRadius,
        ),
        elevation: 0,
        padding: EdgeInsets.symmetric(
          vertical: heightScreen * 0.015,
          horizontal: widthScreen * 0.05
        ),
      ),
      child: Text(
        text,
        style: AppTextStyle.tsBodyBold(AppColor.blue700),
      ),
    );
  }
}