import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/home_page/Component/appbar.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePageScreen extends StatelessWidget {
  const ProfilePageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            appbar(),
            SizedBox(
              height: 50,
            ),
            Container(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 70,
                    backgroundColor: Colors.red,
                    backgroundImage: AssetImage('assets/wacara.png'),
                  ),
                  Positioned(
                    bottom: 15,
                    right: 5,
                    child: Container(
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.purple,
                            border: Border.all(color: Colors.white, width: 1)),
                        child: Icon(Icons.edit)),
                  )
                ],
              ),
            ),
            Text(
              "Sekar",
              style: GoogleFonts.poppins(
                  fontSize: 18, fontWeight: FontWeight.w500),
            ),
            Text(
              "Siswi KB",
              style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 70,
                  width: 150,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: AppColor.blue400),
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 5, left: 20),
                          child: Icon(Icons.abc)),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 15, left: 10),
                            child: Text(
                              "Kelompok",
                              style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Text(
                                "Gajah",
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  height: 70,
                  width: 150,
                  decoration: BoxDecoration(
                      border: Border.all(width: 2, color: AppColor.blue400),
                      borderRadius: BorderRadius.circular(12)),
                  child: Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 5, left: 20),
                          child: Icon(Icons.abc)),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 15, left: 10),
                            child: Text(
                              "Kelompok",
                              style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                  color: Colors.grey),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Text(
                                "Gajah",
                                style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ))
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 230),
                  child: Text(
                    "Nama Lengkap",
                    style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 145),
                  child: Text(
                    "Sekar Idiot Binti Bajuri",
                    style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 2,
                  width: 320,
                  decoration: BoxDecoration(color: AppColor.blue300),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 190),
                  child: Text(
                    "Tempat Tanggal Lahir",
                    style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 160),
                  child: Text(
                    "Kudus , 29 Mei 2020",
                    style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 2,
                  width: 320,
                  decoration: BoxDecoration(color: AppColor.blue300),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: EdgeInsets.only(right: 280),
                  child: Text(
                    "Alamat",
                    style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w600, fontSize: 12),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: Text(
                    "Kuman rt 9 rw 1, kec. Batang, kab. Batang",
                    style: GoogleFonts.manrope(
                        fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 2,
                  width: 320,
                  decoration: BoxDecoration(color: AppColor.blue300),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    width: 330,
                    height: 57,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(13),
                        color: AppColor.blue200),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Laporan Pembelajaran",
                            style: GoogleFonts.manrope(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 80),
                          child: Icon(Icons.abc),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 330,
                      height: 57,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: AppColor.blue200),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              "Laporan Pembelajaran",
                              style: GoogleFonts.manrope(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 80),
                            child: Icon(Icons.abc),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
