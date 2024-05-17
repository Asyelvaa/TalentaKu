import 'package:flutter/material.dart';

import '../../../infrastructure/theme/theme.dart';

class card1 extends StatelessWidget {
  const card1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      padding: EdgeInsets.only(right: 10, bottom: 20),
      height: 333,
      width: 333,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('assets/images/anak.png'),
        fit: BoxFit.cover,
        
      )),
      child: Container(
        width: 50,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: AppColor.white),
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 6),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text("1/4"),
        ),
      ),
    );
  }
}
