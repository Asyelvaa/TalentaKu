import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/navigation/routes.dart';
import 'package:flutter_talentaku/presentation/album_page/album_detail_page.screen.dart';
import 'package:get/get.dart';

class ContentAlbum extends StatelessWidget {
  const ContentAlbum({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 2,
            mainAxisSpacing: 2,
          ),
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => Get.to(AlbumDetailPage()),
                child: Container(
                  color: Colors.grey[300],
                  child: Center(
                    child: Text('image $index'),
                  ),
                ),
              );
            },
            childCount: 8, 
          ),
        ),
      ],
    );
  }
}