import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../infrastructure/theme/theme.dart';

class LaporanPembelajaran extends StatelessWidget {
  final String text;
  final String imageName;

  const LaporanPembelajaran({
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
            width: 240,
            height: 50,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.only(left: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColor.blue100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(text, style: AppTextStyle.tsBodyBold(AppColor.black)),
                defaultWidthtSpace,
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                )
              ],
            ),
          ),
          Positioned(
              left: 40,
              bottom: 20,
              child: Image.asset(
                'assets/images/$imageName',
                scale: 1,
              )),
        ],
      ),
    );
  }
}
