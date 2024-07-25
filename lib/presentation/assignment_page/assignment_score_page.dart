import 'package:flutter/material.dart';

import '../../infrastructure/theme/theme.dart';
import '../global_component/back_appbar.dart';
import '../global_component/text_background.dart';

class AssignmentScorePage extends StatelessWidget {
  const AssignmentScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: BackAppbar(titleAppbar: 'Judul Tugas')),
      body: SingleChildScrollView(
        child: Padding( 
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
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
              SizedBox(height: 12,),
              Row(
                children: [
                  TextWithBackground(colorBackground: AppColor.blue100, text: 'Tengggat : 22 Juli 2024'),
                  TextWithBackground(colorBackground: AppColor.blue100, text: 'Dikumpulkan : 21 Juli 2024'),
                ],
              ),
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
              Divider(),
          
            ],
          ),
        ),
      )
    );
  }
}
