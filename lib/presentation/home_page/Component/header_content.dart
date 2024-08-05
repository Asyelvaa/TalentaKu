import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../infrastructure/theme/theme.dart';

class HeaderContent extends StatelessWidget {
  final String text;
  final String imageName;

  const HeaderContent({
    Key? key,
    required this.text,
    required this.imageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Container(
            width: 330,
            height: 50,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.only(left: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor.blue600),
            child: Center(
              child: Text(text,
                  style: AppTextStyle.tsTitle. copyWith(color: AppColor.white)),
            ),
          ),
          Positioned(left: 40, bottom: 20,  child: Image.asset('assets/images/$imageName', scale: 4,)),
        ],
      ),
    );
  }
}
