import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/daily_report/controllers/daily_report.controller.dart';
import 'package:get/get.dart';

import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/daily_report/component/report_item.dart';

import '../global_component/text_background.dart';

class DailyReportScreen extends GetView<DailyReportController> {
  const DailyReportScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
        backgroundColor: AppColor.blue600,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // HEADER
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColor.blue600,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, bottom: 30, top: 10, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Laporan harian",
                          style: AppTextStyle.tsTitle.copyWith(
                              fontWeight: FontWeight.w800,
                              color: AppColor.white)),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          TextWithBackground(
                            colorBackground: AppColor.white,
                            text: "Semester 1",
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          TextWithBackground(
                            colorBackground: AppColor.white,
                            text: "Jumat, 01/03/2024",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return ReportItem(
                        title: "Kegiatan Awal",
                        description:
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullam",
                        indicator: "Muncul",
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

