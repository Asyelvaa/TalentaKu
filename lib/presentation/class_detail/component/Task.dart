import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../infrastructure/theme/theme.dart';

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
      width: 320,
      height: 90,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: AppColor.blue200),
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 20, top: 25),
                  child: CircleAvatar(
                    child: Icon(Icons.report),
                    backgroundColor: AppColor.blue300,
                    radius: 20,
                  )),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10, top: 20),
                    child: Text(title,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 110),
                    child: Text(
                      date,
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
        ],
      ),
    );
  }
}
