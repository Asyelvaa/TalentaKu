import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../infrastructure/theme/theme.dart';

class HeaderContent extends StatelessWidget {
  final String text;
  final String imagePath;

  const HeaderContent({
    Key? key,
    required this.text,
    required this.imagePath,
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
                color: AppColor.blue300),
            child: Center(
              child: Text(text,
                  style: GoogleFonts.manrope(
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                      color: AppColor.white)),
            ),
          ),
          Positioned(left: 40, bottom: 20, child: Image.asset(imagePath)),
        ],
      ),
    );
  }
}
