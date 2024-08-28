import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'edit_program.dart';
import '../controllers/home_page.controller.dart';

class HomeBottomSheetExtra extends StatelessWidget {
  final String informationTitleExtra;
  final String photoListExtra;
  final String descriptionContentExtra;
  final int extraId;

  HomeBottomSheetExtra({
    Key? key,
    required this.informationTitleExtra,
    required this.photoListExtra,
    required this.descriptionContentExtra,
    required this.extraId,
  }) : super(key: key);

  final HomePageController _homePageController = Get.find();

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
            informationTitleExtra,
            style: AppTextStyle.tsTitle.copyWith(fontSize: 20),
          ),
          SizedBox(height: 20),
          Container(
            height: 200,
            color: Colors.grey[200],
            child: photoListExtra.isEmpty
                ? Center(child: Text("No photos available"))
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      'https://talentaku.site/image/program/$photoListExtra',
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
                  ),
          ),
          SizedBox(height: 20),
          Flexible(
            child: Text(descriptionContentExtra, style: AppTextStyle.tsNormal),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Get.back();
                  _showEditBottomSheet(context);
                },
                child: Container(
                  height: 50,
                  width: Get.width * 0.4,
                  decoration: BoxDecoration(
                    color: AppColor.blue200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Edit',
                      style: AppTextStyle.tsNormal.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.background,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: Get.width * 0.08,
              ),
              GestureDetector(
                onTap: () async {
                  try {
                    await _homePageController.deleteProgram(extraId);

                    Get.snackbar('Success', 'Program deleted successfully');
                  } catch (e) {
                    Get.snackbar('Error', 'Failed to delete program: $e');
                  }
                },
                child: Container(
                  height: 50,
                  width: Get.width * 0.4,
                  decoration: BoxDecoration(
                    color: AppColor.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Delete',
                      style: AppTextStyle.tsNormal.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColor.background,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showEditBottomSheet(BuildContext context) {
    Get.bottomSheet(
      EditProgramPopup(
        programId: extraId,
        initialName: informationTitleExtra,
        initialDesc: descriptionContentExtra,
        initialPhoto: photoListExtra.isNotEmpty ? photoListExtra[0] : '',
        initialCategoryId: 1,
      ),
      isScrollControlled: true,
    );
    // showModalBottomSheet(
    //   context: context,
    //   isScrollControlled: true,
    //   backgroundColor: Colors.transparent,
    //   builder: (BuildContext context) {
    //     return Container(
    //       height: heightScreen * 0.5,
    //       padding: EdgeInsets.all(5),
    //       decoration: BoxDecoration(
    //         borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
    //         color: AppColor.white,
    //       ),
    //       child: EditProgramPopup(
    //         programId: extraId,
    //         initialName: informationTitleExtra,
    //         initialDesc: descriptionContentExtra,
    //         initialPhoto: photoListExtra.isNotEmpty ? photoListExtra[0] : '',
    //         initialCategoryId: 1,
    //       ),
    //     );
    //   },
    // );
  }
}
