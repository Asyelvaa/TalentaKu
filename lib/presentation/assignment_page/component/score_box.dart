import 'package:flutter/material.dart';

import '../../../infrastructure/theme/theme.dart';

class ScoreBox extends StatelessWidget {
  final String score;
  final bool isSelected;

  const ScoreBox({required this.score, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all( 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isSelected ? AppColor.blue500 : Colors.grey,
        shape: BoxShape.circle
      ),
      child: Text(
        score,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );  
  }
}