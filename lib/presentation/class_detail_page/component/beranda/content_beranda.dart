import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../infrastructure/theme/theme.dart';
import 'Task.dart';

class ContentBeranda extends StatelessWidget {
  const ContentBeranda({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Task(title: "Tugas baru : Matematika Dasar", date: "Feb 02, 2024"),
                Container(
                  margin: EdgeInsets.only(top: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20), 
                      color: AppColor.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2), 
                          blurRadius: 2, 
                          offset: Offset(0, 1), 
                        )
                      ]
                  ),
                  width: 320,
                  height: 300,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 20, top: 25),
                              child: CircleAvatar(
                                child: Image.asset("assets/images/student.png"),
                                radius: 16,
                              )),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 30, top: 20),
                                child: Text("Anita Fauza",
                                    style: AppTextStyle.tsLittle),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 40, left: 10),
                                child: Text(
                                  "May 05 2024",
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
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                        child: Text(
                            "Selamat Pagi\nBerikut adalah pemberitahuan mengenai Libur Lebaran"),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                  padding:
                                      const EdgeInsets.only(left: 20, top: 15),
                                  child: Image.asset("assets/images/pdf.png")),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 25, top: 10),
                                    child: Text("Pemberitahuan Libur Lebaran",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                        )),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(right: 200, left: 10),
                                    child: Text(
                                      "PDF",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12,
                                          color: AppColor.grey),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            height: 1,
                            width: 280,
                            decoration: BoxDecoration(color: AppColor.black),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: CircleAvatar(
                                    child: Image.asset("assets/images/photo.png"),
                                    radius: 20,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
          ],
        ),
      ),
    );
  }
}