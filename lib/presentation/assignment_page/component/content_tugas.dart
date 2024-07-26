import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:get/get.dart';

import '../../global_component/text_background.dart';
import '../controllers/assignment_page.controller.dart';

class ContentTugas extends GetView<AssignmentPageController> {
  const ContentTugas({super.key});

  @override
  Widget build(BuildContext context) {
    var task = controller.task!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12,),
        TextWithBackground(colorBackground: AppColor.grey, text: 'Tengggat : ${task.endDate}'),
        SizedBox(height: 12,),
        Text(
          task.desc.join('\n'),
          style: AppTextStyle.tsLittle,
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 12,),
        Text('Lampiran : ', style: AppTextStyle.tsLittle),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: task.media.length,
          itemBuilder: (context, index) {
            final media = task.media[index];
            return GestureDetector(
              onTap: () {
                // Handle media tap
              },
              child: Container(
                height: 60,
                margin: EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: AppColor.grey,
                      ),
                      child: Image.network(
                        'https://talentaku.site/image/task/${media.fileName}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Media ${index + 1}', style: AppTextStyle.tsLittle,),
                          Text(media.fileName, style: AppTextStyle.tsLittle, maxLines: 1, overflow: TextOverflow.ellipsis,)
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            );
          },
        ),
        SizedBox(height: 12,),
        Text('Links : ', style: AppTextStyle.tsLittle),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: task.links.length,
          itemBuilder: (context, index) {
            final link = task.links[index];
            return GestureDetector(
              onTap: () {
                // Handle link tap
              },
              child: Container(
                height: 60,
                margin: EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(Icons.link, size: 24,),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(link.url, style: AppTextStyle.tsLittle,)
                    ))
                  ],
                ),
              ),
            );
          },
        ),
        SizedBox(height: 12,),
        // ElevatedButton(
        //   onPressed: () async {},
        //   child: Center(
        //     child: Text(
        //       'Edit Tugas',
        //       style: AppTextStyle.tsLittle,
        //     ),
        //   ),
        //   style: ElevatedButton.styleFrom(
        //     fixedSize: Size.fromHeight(44),
        //     elevation: 0,
        //     backgroundColor: AppColor.blue100,
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.circular(16),
        //     ),
        //   ),
        // ),
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
