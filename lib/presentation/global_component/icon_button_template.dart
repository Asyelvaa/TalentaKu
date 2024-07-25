import 'package:flutter/material.dart';

import '../../infrastructure/theme/theme.dart';

class IconButtonTemplate extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color colorButton;
  final VoidCallback onPressed;

  const IconButtonTemplate({
    Key? key,
    required this.text,
    this.icon,
    required this.colorButton,
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
            borderRadius: BorderRadius.circular(12),
          )
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: AppTextStyle.tsTitle.copyWith(color: AppColor.white),
          ),
          Icon(
            icon,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
