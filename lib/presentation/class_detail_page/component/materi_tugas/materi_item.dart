import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../infrastructure/theme/theme.dart';

class MateriItem extends StatelessWidget {
  final String title;
  final String tenggat;
  const MateriItem({
    super.key,
    required this.title,
    required this.tenggat
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      width: widthScreen,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), 
          color: AppColor.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), 
              blurRadius: 2, 
              offset: Offset(0, 1), 
            )
          ]
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  child: Icon(Icons.assignment, color: AppColor.black,size: 20  ,),
                  backgroundColor: AppColor.blue100,
                  radius: 16,
                ),
                SizedBox(width: 8,),
                Text(title,
                    style: AppTextStyle.tsLittle
                ),
                SizedBox(width: 8,),
                Text(tenggat, style: AppTextStyle.tsLittle,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
