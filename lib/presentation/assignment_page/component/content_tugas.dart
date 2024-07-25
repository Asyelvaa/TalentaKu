import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:get/get.dart';

import '../../global_component/text_background.dart';
import '../controllers/assignment_page.controller.dart';

class ContentTugas extends GetView<AssignmentPageController> {
  const ContentTugas({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12,),
        TextWithBackground(colorBackground: AppColor.grey, text: 'Tengggat : 22 Juli 2024'),
        SizedBox(height: 12,),
        Text(
          'Description Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis auctor commodo consectetur. Proin suscipit consectetur sem, et pharetra tortor egestas at. Aliquam eget sapien ut tortor posuere ultrices. Sed tristique, ante ',
          style: AppTextStyle.tsLittle,
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 12,),
        GestureDetector(
          onTap: () {},
          child: Container(
            height: 60,
            child: Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: AppColor.grey,
                  ),                  
                ),
                Expanded(child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Judul Lampiran', style: AppTextStyle.tsLittle,),
                      Text('Gambar/PDF/Video', style: AppTextStyle.tsLittle,)
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
        SizedBox(height: 12,),
        ElevatedButton(
          onPressed: () async {},
          child: Center(
            child: Text(
              'Edit Tugas',
              style: AppTextStyle.tsLittle,
            ),
          ),
          style: ElevatedButton.styleFrom(
            fixedSize: Size.fromHeight(44),
            elevation: 0,
            backgroundColor: AppColor.blue100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        Divider(),
        Row(
          children: [
            Icon(Icons.people, size: 24,),
            defaultWidthtSpace,
            Text('Komentas Kelas', style: AppTextStyle.tsLittle)
          ],
        )
      ],
    );
  }
}
