import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:flutter_talentaku/presentation/student_report_page/component/media_fullscreen.dart';

class MediaDisplay extends StatelessWidget {
  final List<dynamic> media;

  const MediaDisplay({Key? key, required this.media}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child:
                Text("Media", style: AppTextStyle.tsBodyBold(AppColor.black)),
          ),
          SizedBox(height: 10),
          Container(
            height: heightScreen * 0.4,
            width: widthScreen,
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 2,
              ),
              itemCount: media.length,
              itemBuilder: (context, index) {
                final filename = media[index]['file_path'];
                final imageUrl =
                    "https://talentaku.site/image/student-report/$filename";
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              FullScreenImage(imageUrl: imageUrl),
                        ),
                      );
                    },
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
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
