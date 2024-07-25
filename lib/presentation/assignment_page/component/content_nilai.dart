import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/assignment_page/assignment_score_page.dart';
import 'package:get/get.dart';

class ContentNilai extends StatelessWidget {
  const ContentNilai({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(vertical : 8),
        child: GestureDetector(
          onTap: () {Get.to(AssignmentScorePage());},
          child: Container(
            // height: 44,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColor.grey)
            )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    child: Image.asset("assets/images/student.png"),
                    radius: 20,
                    backgroundColor: AppColor.blue100,
                  ),
                  defaultWidthtSpace,
                  Expanded(child: Text('Dimas Prayoga')),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColor.blue600,
                      shape: BoxShape.circle
                    ),
                    child: Text('A', style: AppTextStyle.tsLittle.copyWith(color: AppColor.white, fontWeight: FontWeight.bold),),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical : 8),
        child: GestureDetector(
          child: Container(
            // height: 44,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColor.grey)
            )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  CircleAvatar(
                    child: Image.asset("assets/images/student.png"),
                    radius: 20,
                    backgroundColor: AppColor.blue100,
                  ),
                  defaultWidthtSpace,
                  Expanded(child: Text('Gwenn Ashley')),
                  
                ],
              ),
            ),
          ),
        ),
      )

    ],);
  }
} 