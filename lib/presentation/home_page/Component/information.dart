import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/home/controllers/home.controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../infrastructure/theme/theme.dart';

class information extends GetView<HomeController> {
  final String? title;
  final String? date;
  const information({
    this.title,
    this.date,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 10),
                child: CircleAvatar(
                  child: Icon(Icons.report),
                  backgroundColor: AppColor.blue300,
                  radius: 15,
                )),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  child: Text(title!,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    date!,
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 11,
                        color: Colors.black),
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 3,
          width: 230,
          decoration: BoxDecoration(color: AppColor.grey),
        )
      ],
    );
  }
}
