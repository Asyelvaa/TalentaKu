import 'package:flutter/material.dart';

import '../../infrastructure/theme/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color colorButton;
  final Color colorText;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    required this.colorButton,
    required this.colorText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(colorButton),
          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
              EdgeInsets.symmetric(vertical: 16, horizontal: 24)),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: defaultBorderRadius,
          ))),
      child: Center(
        child: Text(
          text,
          style: AppTextStyle.tsBodyBold(colorText),
        ),
      ),
    );
  }
}
