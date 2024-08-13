import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';

class CustomWidgetClassButtonActionItem extends StatelessWidget {
  final String buttonName;
  final IconData buttonIcon;
  final VoidCallback onTap;
  CustomWidgetClassButtonActionItem({
    super.key,
    required this.buttonName,
    required this.buttonIcon,
    required this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthScreen,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: widthScreen * 0.1, vertical: heightScreen * 0.02),
          backgroundColor: AppColor.blue50,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(buttonIcon, color: AppColor.blue600),
            defaultWidthtSpace,
            Text('${buttonName}', style: AppTextStyle.tsBodyBold(AppColor.black)),
          ],
        ),
      ),
    );
  }
}