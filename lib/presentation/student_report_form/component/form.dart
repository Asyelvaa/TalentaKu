import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';
import '../controllers/student_report_form.controller.dart';

class FormSection extends StatelessWidget {
  final StudentReportFormController controller;
  final String sectionTitle;
  final TextEditingController textController;
  final String pointType;

  FormSection(
      {Key? key,
      required this.controller,
      required this.sectionTitle,
      required this.pointType,
      required this.textController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      String? selectedOption = controller.selectedOptions[sectionTitle];

      return Container(
        padding: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          border: Border.all(width: 1.5, color: AppColor.blue500),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Masukkan Catatan...',
                hintStyle: AppTextStyle.tsLittle,
                fillColor: AppColor.white,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide(color: AppColor.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  borderSide: BorderSide(color: AppColor.white),
                ),
              ),
              maxLines: null,
              minLines: 1,
            ),
            spaceHeightExtraSmall,
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text('Hasil:',
                      style: AppTextStyle.tsSmallBold(AppColor.black)),
                ),
                defaultWidthtSpace,
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
                spaceHeightExtraSmall,
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
                spaceHeightExtraSmall,
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
