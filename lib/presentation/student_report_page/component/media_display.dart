import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';

class MediaDisplay extends StatelessWidget {
  final List<dynamic>
      media; // Change type to List<dynamic> for better flexibility

  const MediaDisplay({Key? key, required this.media}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(22),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Media", style: AppTextStyle.tsBodyBold(AppColor.black)),
            SizedBox(height: 10),
            Container(
              height: heightScreen * 0.2,
              width: widthScreen,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemCount: media.length,
                itemBuilder: (context, index) {
                  final filename = media[index]['file_path'];
                  final imageUrl =
                      "https://talentaku.site/image/student-report/$filename";
                  return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          print("Error loading image: $error");
                          return Text('Image error');
                        },
                      ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
