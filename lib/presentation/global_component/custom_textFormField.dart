import 'package:flutter/material.dart';

import '../../infrastructure/theme/theme.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.loginController,
    required this.labelText,
    this.isPassword = false,
  });

  final TextEditingController loginController;
  final String labelText;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: loginController,
      obscureText: isPassword,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: 12, horizontal: 10),
        enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: AppColor.grey),
            borderRadius:
                BorderRadius.all(Radius.circular(12))),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColor.blue500),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.blue500),
        ),
        suffixIcon: isPassword
            ? Icon(
                  Icons.visibility_off_outlined,
                  color: AppColor.black,
                  size: 20,
            )
            : null,
        labelText:labelText,
        labelStyle: AppTextStyle.tsLittle,
      ),
    );
  }
}