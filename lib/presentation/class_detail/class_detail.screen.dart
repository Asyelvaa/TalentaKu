import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'component/Task.dart';
import 'component/header_class.dart';
import '../../infrastructure/theme/theme.dart';
import 'controllers/class_detail.controller.dart';
 
class ClassDetailScreen extends GetView<ClassDetailController> {
  const ClassDetailScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        leading: IconButton(onPressed: () {Get.back();}, icon: Icon(Icons.arrow_back)),
        backgroundColor: AppColor.blue600,
        title: Text(
          "Kelompok pelangi",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // HEADER
            HeaderClass(),
            // BODY
            Task(title: "Tugas baru : Matematika Dasar", date: "Feb 02 2024"),
            SizedBox(height: 20),
            Container(
              width: 320,
              height: 300,
              decoration: BoxDecoration(borderRadius: defaultBorderRadius),
              child: Column(
                children: [
                  Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 20, top: 25),
                          child: CircleAvatar(
                            child: Image.asset("assets/images/photo.png"),
                            radius: 20,
                          )),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 30, top: 20),
                            child: Text("Sekar Anisa",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                )),
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

