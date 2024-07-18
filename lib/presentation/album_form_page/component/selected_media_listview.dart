import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/album_form_page/controllers/album_form.controller.dart';
import 'package:get/get.dart';

import '../../../infrastructure/theme/theme.dart';

class SelectedMediaListView extends GetView<AlbumFormController> {

  SelectedMediaListView({Key? key}) : super(key: key);

  Future<ui.Image> _loadImage(File file) async {
    final data = await file.readAsBytes();
    final codec = await ui.instantiateImageCodec(data);
    final frame = await codec.getNextFrame();
    return frame.image;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.grey,
      height: heightScreen * 0.4,
      width: widthScreen,
      child: ListView.builder(
        controller: controller.pageController,
        scrollDirection: Axis.horizontal,
        itemCount: controller.selectedMedia.length,
        itemBuilder: (context, index) {
          final file = controller.selectedMedia[index];

          return FutureBuilder<ui.Image>(
            future: _loadImage(file),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                final image = snapshot.data!;
                final aspectRatio = image.width / image.height;

                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: file.path.endsWith('.mp4')
                      ? AspectRatio(
                          aspectRatio: 1.0, // Adjust aspect ratio for videos
                          child: Icon(Icons.video_library),
                        )
                      : AspectRatio(
                          aspectRatio: aspectRatio,
                          child: Image.file(
                            file,
                            fit: BoxFit.scaleDown,
                            // fit: BoxFit.contain,
                          ),
                        ),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          );
        },
      ),
    );
  }
}