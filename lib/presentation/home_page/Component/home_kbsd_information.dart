import 'package:flutter/material.dart';

import '../../../infrastructure/theme/theme.dart';

class KbSdTalentaComponent extends StatelessWidget {
  const KbSdTalentaComponent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthScreen * 0.5,
      height: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColor.blue700),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Text("KB & SD \nInklusi Talenta",
            textAlign: TextAlign.start,
            style: AppTextStyle.tsNormal.copyWith(color: AppColor.white)),
      ),
    );
  }
}
