import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';

import 'content.dart';
import 'header_content.dart';

class SlideExtra extends StatelessWidget {
  final String headerContent;
  final List<String> contenExtra;
  final void Function()? onTap;
  final String image;

  const SlideExtra({
    Key? key,
    required this.headerContent,
    required this.contenExtra,
    this.onTap,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          HeaderContent(text: headerContent, imageName: image),
          Container(
            padding: EdgeInsets.only(left: 20),
            width: double.infinity,
            height: heightScreen * 0.13,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: contenExtra.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: onTap,
                  child: Content(
                    contenExtra: contenExtra[index],
                    index: index,
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
