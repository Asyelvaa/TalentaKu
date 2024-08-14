import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';

class CustomButtonActionMain extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  
  const CustomButtonActionMain({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    
    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColor.blue600,
        shape: RoundedRectangleBorder(
          borderRadius: defaultBorderRadius,
        ),
        padding: EdgeInsets.symmetric(
          vertical: heightScreen * 0.015,
          horizontal: widthScreen * 0.05
        ),
        elevation: 0,
      ),
      child: isLoading
          ? SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: AppColor.white,
                strokeWidth: 2.0,
              ),
            )
          : Text(
              text,
              style: AppTextStyle.tsBodyBold(AppColor.white),
            ),
    );
  }
}