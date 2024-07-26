import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/theme.dart';
import '../global_component/back_appbar.dart';
import '../global_component/text_background.dart';
import 'component/score_box.dart';
import 'controllers/assignment_page.controller.dart';

class AssignmentScorePage extends StatelessWidget {
  const AssignmentScorePage({super.key});

  @override
  Widget build(BuildContext context) {
  final controller = Get.put(AssignmentPageController());
    return Scaffold(
        backgroundColor: AppColor.background,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: BackAppbar(titleAppbar: 'Judul Tugas')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: Image.asset("assets/images/student.png"),
                      radius: 20,
                      backgroundColor: AppColor.blue100,
                    ),
                    defaultWidthtSpace,
                    Expanded(child: Text('Dimas Prayoga')),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    TextWithBackground(
                        colorBackground: AppColor.blue100,
                        text: 'Tengggat : 22 Juli 2024'),
                    TextWithBackground(
                        colorBackground: AppColor.blue100,
                        text: 'Dikumpulkan : 21 Juli 2024'),
                  ],
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Description Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis auctor commodo consectetur. Proin suscipit consectetur sem, et pharetra tortor egestas at. Aliquam eget sapien ut tortor posuere ultrices. Sed tristique, ante ',
                  style: AppTextStyle.tsLittle,
                  textAlign: TextAlign.justify,
                ),
                SizedBox(
                  height: 12,
                ),
                Text('Lampiran : ', style: AppTextStyle.tsLittle),
                defaultHeightSpace,
                // ListView.builder(
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemCount: task.media.length,
                //   itemBuilder: (context, index) {
                //     final media = task.media[index];
                //     return GestureDetector(
                //       onTap: () {
                //         // Handle media tap
                //       },
                //       child: Container(
                //         height: 60,
                //         margin: EdgeInsets.only(bottom: 8),
                //         child: Row(
                //           children: [
                //             Container(
                //               height: 60,
                //               width: 60,
                //               decoration: BoxDecoration(
                //                 color: AppColor.grey,
                //               ),
                //               child: Image.network(
                //                 'https://talentaku.site/image/task-submission/${media.fileName}',
                //                 fit: BoxFit.cover,
                //               ),
                //             ),
                //             Expanded(
                //                 child: Padding(
                //               padding: const EdgeInsets.all(8.0),
                //               child: Column(
                //                 crossAxisAlignment: CrossAxisAlignment.start,
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceEvenly,
                //                 children: [
                //                   Text(
                //                     'Media ${index + 1}',
                //                     style: AppTextStyle.tsLittle,
                //                   ),
                //                   Text(
                //                     media.fileName,
                //                     style: AppTextStyle.tsLittle,
                //                     maxLines: 1,
                //                     overflow: TextOverflow.ellipsis,
                //                   )
                //                 ],
                //               ),
                //             ))
                //           ],
                //         ),
                //       ),
                //     );
                //   },
                // ),
                Divider(),
                Row(
                  children: [
                    Text('Beri Nilai : '),
                     GestureDetector(
                        onTap: () => controller.score.value = 'A',
                        child: Obx(() => ScoreBox(score: 'A', isSelected: controller.score.value == 'A')),
                      ),
                      GestureDetector(
                        onTap: () => controller.score.value = 'B',
                        child: Obx(() => ScoreBox(score: 'B', isSelected: controller.score.value == 'B')),
                      ),
                      GestureDetector(
                        onTap: () => controller.score.value = 'C',
                        child: Obx(() => ScoreBox(score: 'C', isSelected: controller.score.value == 'C')),
                      ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () async {
                      
                    }, 
                    child: Center(
                      child: Text(
                        'Kirim Nilai',
                        style: AppTextStyle.tsNormal,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size.fromHeight(50),
                      backgroundColor: AppColor.blue100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ));
  }
}
