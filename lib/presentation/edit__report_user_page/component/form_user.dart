import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';
import '../../student_report_form/controllers/student_report_form.controller.dart';
import '../controllers/edit_report_user_page.controller.dart';


class FormSection extends StatelessWidget {
  final EditReportUserPageController controller;
  final String sectionTitle;
  
  final TextEditingController textController;
  final String pointType;

  FormSection(
      {Key? key,
      required this.controller,
      required this.sectionTitle,
      required this.pointType,
      required this.textController, 
})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      String? selectedOption = controller.selectedOptions[sectionTitle];

      return Container(
        height: 180,
        width: 325,
        decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: AppColor.blue500),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: textController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Masukkan catatan',
                border: InputBorder.none,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 14, horizontal: 16),
              ),
            ),
            SizedBox(height: 5),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text('Hasil:', style: AppTextStyle.tsNormal),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () {
                    controller.select(sectionTitle, 'Muncul');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    decoration: BoxDecoration(
                      color: selectedOption == 'Muncul'
                          ? AppColor.blue500
                          : AppColor.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Muncul',
                      style: AppTextStyle.tsLittle.copyWith(
                        color: selectedOption == 'Muncul'
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    controller.select(sectionTitle, 'Kurang');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    decoration: BoxDecoration(
                      color: selectedOption == 'Kurang'
                          ? AppColor.blue500
                          : AppColor.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Kurang',
                      style: AppTextStyle.tsLittle.copyWith(
                        color: selectedOption == 'Kurang'
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    controller.select(sectionTitle, 'Belum Muncul');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                    decoration: BoxDecoration(
                      color: selectedOption == 'Belum Muncul'
                          ? AppColor.blue500
                          : AppColor.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'Belum Muncul',
                      style: AppTextStyle.tsLittle.copyWith(
                        color: selectedOption == 'Belum Muncul'
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
