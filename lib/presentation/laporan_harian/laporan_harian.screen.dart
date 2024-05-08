import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/laporan_harian/component/report_item.dart';
import 'package:flutter_talentaku/presentation/laporan_harian/controllers/laporan_harian.controller.dart';

class LaporanHarianScreen extends GetView<LaporanHarianController> {
  const LaporanHarianScreen({Key? key}) : super(key: key);
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
                          Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text("Semester 1",
                                  style: AppTextStyle.tsLittle)),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text("Jumat, 01/03/2024",
                                style: AppTextStyle.tsLittle),
                          )
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
