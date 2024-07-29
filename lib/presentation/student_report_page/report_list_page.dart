import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';
import '../common_widget/back_appbar.dart';
import 'controllers/daily_report.controller.dart';

class ReportListPage extends StatelessWidget {
  const ReportListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DailyReportController());
    // final data = controller.reportData[0];
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: BackAppbar(titleAppbar: 'Laporan Pembelajaran')),
      body: 
      ListTile(
        title: Text('Laporan Harian 1'),
        onTap: (){
          Get.toNamed(Routes.DAILY_REPORT);
        },
        trailing: Icon(Icons.arrow_forward_ios),
      )
      // body: Obx((){
      //   if(controller.reportData.isEmpty){
      //     return Column(
      //       mainAxisAlignment: MainAxisAlignment.center,
      //       children: [
      //         Image.asset("assets/images/stiker_kelas.png", scale: 2.5,),
      //           Text('Anda Belum Memiliki Laporan Pembelajaran', 
      //             style: AppTextStyle.tsTitle.copyWith(color: AppColor.blue800), textAlign: TextAlign.center,
      //           ),
      //       ],
      //     );
      //   } else if (controller.isLoading.value){
      //     return Center(child: CircularProgressIndicator());
      //   }
      //   else {
      //     return ListView.builder(
      //       itemCount: controller.reportData.length,
      //       itemBuilder: (context, index){
      //         return ListTile(
      //           title: Text(controller.reportData[0]['cretaed']),
      //           // subtitle: Text(controller.reportData[index].description),
      //           onTap: (){
      //             Get.toNamed(Routes.DAILY_REPORT);
      //           },
      //         );
      //       },
      //     );
      //   }
      // }),
    );
  }
}