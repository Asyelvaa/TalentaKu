import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';

class listSiswa extends StatelessWidget {
  const listSiswa({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: heightScreen * 0.1,
        width: widthScreen,
        decoration: BoxDecoration(
          color: AppColor.blue100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                  radius: 30, child: Image.asset('assets/images/student.png')),
            ),
            Text(
              "Siswa",
              style: AppTextStyle.tsNormal,
            )
          ],
        ),
      ),
    );
  }
}
