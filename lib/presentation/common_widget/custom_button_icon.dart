import 'package:flutter/material.dart';

import '../../infrastructure/theme/theme.dart';

class CustomButtonWithIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color colorButton;
  final Color colorText;
  final Color colorIcon;
  final VoidCallback onPressed;

  const CustomButtonWithIcon({
    Key? key,
    required this.text,
    required this.icon,
    required this.colorButton,
    required this.colorText,
    required this.colorIcon,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(colorButton),
          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(vertical: 16, horizontal: 24)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: AppTextStyle.tsTitleBold(colorText),
          ),
          Icon(
            icon,
            color: AppColor.black,
          ),
        ],
      ),
    );
  }
}
