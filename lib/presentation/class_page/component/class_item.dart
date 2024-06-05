import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/models/class_model.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/theme/theme.dart';
import '../../class_detail_page/class_detail.screen.dart';

class ClassItem extends StatelessWidget {

  ClassItem({Key? key, }) : super(key: key);
  @override
  final List<ClassModel> _classItems = [
  ClassModel(
    id: '1',
    name: 'Kelompok Pelangi',
    teacher : 'Anita Fauzah',
    description: 'Kelas KB',
    isActive: true , 
  ),
  ClassModel(
    id: '2',
    name: 'Kelompok Gajah',
    teacher : 'Anita Fauzah',
    description: 'Kelas SD',
    isActive: false, 
  ),
];

  Widget build(BuildContext context) { 
     return ListView.builder(
      itemCount: _classItems.length,
      itemBuilder: (context, index) {
        final ClassModel classItem = _classItems[index];
        return InkWell(
          onTap: () => Get.toNamed(
              Routes.CLASS_DETAIL,
              arguments: classItem,
          ),
          child: Container(
            margin: EdgeInsets.only(top: 12),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            width: widthScreen,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: classItem.isActive ? AppColor.blue200 : Colors.grey[200],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      classItem.name,
                      style: AppTextStyle.tsNormal,
                    ),
                    Text(
                      classItem.description,
                      style: AppTextStyle.tsLittle,
                    ),
                    Text(
                      classItem.isActive ? '' : 'Archived Class',
                      style: AppTextStyle.tsLittle,
                    )
                  ],
                ),
                Image.asset(
                  "assets/images/abc.png",
                  scale: 1.5,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
