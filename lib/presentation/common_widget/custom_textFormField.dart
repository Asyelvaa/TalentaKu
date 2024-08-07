import 'package:flutter/material.dart';
import '../../infrastructure/theme/theme.dart';

class CustomTextFormField extends StatefulWidget {
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
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.loginController,
      obscureText: widget.isPassword && !_isPasswordVisible,
      style: AppTextStyle.tsBodyRegular(AppColor.black),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02,
          horizontal: MediaQuery.of(context).size.width * 0.05,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.grey),
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColor.blue500),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.blue500),
        ),
        fillColor: AppColor.white,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColor.black,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null,
        labelText: widget.labelText,
        labelStyle: AppTextStyle.tsSmallRegular(AppColor.black),
      ),
    );
  }
}
