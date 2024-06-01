import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';

import 'package:get/get.dart';

import 'component/component1.dart';
import 'controllers/style_album.controller.dart';

class StyleAlbumScreen extends GetView<StyleAlbumController> {
  const StyleAlbumScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        title: const Text(
          'Album',
        ),
        backgroundColor: AppColor.background,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back)),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              child: ListView.builder(
                itemCount: 4,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Container(
                    child: component1(
                        Foto: "assets/images/mobil.png",
                        description:
                            "Description Lorem ipsum dolor sit amet, consectetur adipiscing elit."),
                  );
                },
              ),
            ),
          ],
        )),
      ),
    );
  }
}
