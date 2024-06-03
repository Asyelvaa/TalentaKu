import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'component/post_card.dart';
import 'controllers/style_album.controller.dart';
import 'model/post_card_model.dart';

class AlbumDetailPage extends GetView<StyleAlbumController> {
  const AlbumDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PostCardModel> cards = [
      PostCardModel(
        photo: "assets/images/mobil.png",
        description:
            "Description Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis auctor commodo halo gais nama rizky radithya",
        title: "Judul Foto Kegiatan",
        datePost: "May, 05 2024",
      ),
      PostCardModel(
        photo: "assets/images/mobil.png",
        description:
            "Description Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis auctor commodo anjung anjai mabar slemek",
        title: "Judul Foto Kegiatan",
        datePost: "May, 05 2024",
      ),
    ];

    return Scaffold(
      backgroundColor: AppColor.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'Post',
          style: GoogleFonts.manrope(
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                itemCount: cards.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return PostCard(
                    postCardModel: cards[index],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
