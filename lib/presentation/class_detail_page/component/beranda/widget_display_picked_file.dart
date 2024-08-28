// import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:get/get.dart';
import 'dart:io';

import '../../controllers/class_detail.controller.dart';
import 'pdf_viewer_screen.dart';

class CustomWidgetDisplayPickedFile extends StatelessWidget {
  final File file;
  final double widthScreen;
  final double heightScreen;
  final VoidCallback? onRemove;

  CustomWidgetDisplayPickedFile({
    required this.file,
    required this.widthScreen,
    required this.heightScreen,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   height: 10,
    //   color: AppColor.black,
    // );
    String fileExtension = file.path.split('.').last.toLowerCase();
    if (fileExtension == 'pdf') {
      return ListTile(
        leading: Icon(Icons.picture_as_pdf, color: AppColor.black),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: AppColor.red),
          onPressed: onRemove
        ),
        title: Text('${file.path.split('/').last}'),
        subtitle: Text('Type: PDF'),
        onTap: () {},
        // onTap: () => Get.to(() => PDFViewerScreen(file: file)),
      );
      // return FutureBuilder<Image>(
      //   future: _generatePdfPreview(file),
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
      //       return ListTile(
      //         leading: Icon(Icons.picture_as_pdf, color: Colors.red),
      //         title: Text('${file.path.split('/').last}'),
      //         subtitle: Text('Type: PDF'),
      //         onTap: () => Get.to(() => PDFViewerScreen(file: file)),
      //       );
      //     } else {
      //       return ListTile(
      //         leading: Container(
      //           width: widthScreen * 0.2,
      //           height: heightScreen * 0.15,
      //           child: Center(child: CircularProgressIndicator()),
      //         ),
      //         title: Text('${file.path.split('/').last}'),
      //         subtitle: Text('Type: PDF'),
      //       );
      //     }
      //   },
      // );
    // } else if (['mp4', 'mov'].contains(fileExtension)) {
    //   VideoPlayerController videoController = VideoPlayerController.file(file);
    //   // ChewieController chewieController = ChewieController(
    //   //   videoPlayerController: videoController,
    //   //   aspectRatio: 16 / 9,
    //   //   autoPlay: false,
    //   //   looping: false,
    //   // );
    // return FutureBuilder(
    //   future: videoController.initialize(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       return Stack(
    //         children: [
    //           GestureDetector(
    //             onTap: () {
    //               videoController.play();
    //               Get.to(() => Scaffold(
    //                     backgroundColor: Colors.black,
    //                     body: Center(
    //                       child: AspectRatio(
    //                         aspectRatio: videoController.value.aspectRatio,
    //                         // child: VideoPlayer(videoController),
    //                       ),
    //                     ),
    //                     floatingActionButton: FloatingActionButton(
    //                       onPressed: () {
    //                         if (videoController.value.isPlaying) {
    //                           videoController.pause();
    //                         } else {
    //                           videoController.play();
    //                         }
    //                       },
    //                       child: Icon(
    //                         videoController.value.isPlaying ? Icons.pause : Icons.play_arrow,
    //                       ),
    //                     ),
    //                   ))?.then((_) {
    //                 videoController.pause();
    //               });
    //             },
    //             child: ClipRRect(
    //               borderRadius: BorderRadius.circular(8),
    //               child: Stack(
    //                 alignment: Alignment.center,
    //                 children: [
    //                   Container(
    //                     width: widthScreen * 0.3,
    //                     height: heightScreen * 0.15,
    //                     // child: VideoPlayer(videoController),
    //                   ),
    //                   Icon(Icons.play_circle_fill, color: Colors.white, size: 40),
    //                 ],
    //               ),
    //             ),
    //           ),
    //           Positioned(
    //             right: 4,
    //             top: 4,
    //             child: GestureDetector(
    //               onTap: onRemove,
    //               child: Container(
    //                 decoration: BoxDecoration(
    //                   color: Colors.red,
    //                   shape: BoxShape.circle,
    //                 ),
    //                 child: Icon(
    //                   Icons.close,
    //                   color: Colors.white,
    //                   size: 20,
    //                 ),
    //               ),
    //             ),
    //           ),
    //         ],
    //       );
    //       } else {
    //       return Container(
    //         width: widthScreen * 0.3,
    //         height: heightScreen * 0.15,
    //         color: Colors.black,
    //         child: Center(child: CircularProgressIndicator()),
    //       );
    //     }
    //   },
    // );
      } else {
      return Stack(
        children: [
          GestureDetector(
            onTap: () => showGeneralDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
              barrierColor: Colors.black,
              pageBuilder: (BuildContext context, Animation first, Animation second) {
                return Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => Get.back(),
                      ),
                      SizedBox(height: 16.0),
                      InteractiveViewer(
                        child: Image.file(File(file.path)),
                      ),
                    ],
                  ),
                );
              },
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.file(
                File(file.path),
                width: widthScreen * 0.3,
                height: heightScreen * 0.15,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            right: 4,
            top: 4,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      );
    }
  }

  //  Future<Image> _generatePdfPreview(File file) async {
  //    final pdfDocument = await PdfDocument.openFile(file.path);
  //    final page = await pdfDocument.getPage(1);
  //    final pageImage = await page.render(
  //      width: widthScreen * 0.2,
  //      height: heightScreen * 0.15,
  //      format: PdfPageImageFormat.png,
  //    );
  //    await page.close();
  //    return Image.memory(pageImage!.bytes);
  //  }
}
