import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';

class HomeBottomsheetInformation extends StatelessWidget {
  final String informationTitle;
  final List<String> photoList;
  final String descriptionContent;

  const HomeBottomsheetInformation({
    Key? key,
    required this.informationTitle,
    required this.photoList,
    required this.descriptionContent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: AppColor.white,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
            ),
          ),
          SizedBox(height: 10),
          Text(
            informationTitle,
            style: AppTextStyle.tsTitle.copyWith(fontSize: 20),
          ),
          SizedBox(height: 20),
          Container(
            height: 200,
            color: Colors.grey[200],
            child: photoList.isEmpty
                ? Center(child: Text("No photos available"))
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: photoList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(photoList[index],
                        fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey,
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            );
                          },
                        ), 
                      );
                    },
                  ),
          ),
          SizedBox(height: 20),
          Flexible(
            child: SingleChildScrollView(
              child: Text(
                descriptionContent,
                style: AppTextStyle.tsNormal.copyWith(fontWeight: FontWeight.normal),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: Size(double.infinity, 50), // Button size
            ),
            child: Text('Kembali', style: AppTextStyle.tsNormal.copyWith(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
