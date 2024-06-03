import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:get/get.dart';

class StyleAlbum extends StatelessWidget {
  const StyleAlbum({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        leading: IconButton(onPressed: () {Get.back();}, icon: Icon(Icons.arrow_back)),
      ),
    );
  }
}