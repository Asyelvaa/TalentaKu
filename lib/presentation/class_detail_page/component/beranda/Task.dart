import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../infrastructure/theme/theme.dart';

class Task extends StatelessWidget {
  final String title;
  final String date;
  const Task({
    super.key,
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthScreen,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 2,
              offset: Offset(0, 1),
            )
          ]),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  child: Icon(
                    Icons.assignment,
                    color: AppColor.black,
                    size: 20,
                  ),
                  backgroundColor: AppColor.blue100,
                  radius: 16,
                ),
                defaultWidthtSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        )),
                    Text(
                      date,
                      style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 11,
                          color: Colors.black),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
