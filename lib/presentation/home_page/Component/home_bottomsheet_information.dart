import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'edit_program.dart';
import '../controllers/home_page.controller.dart';

class HomeBottomsheetInformation extends StatelessWidget {
  final String informationTitle;
  final String photoList;
  final String descriptionContent;
  final int programId;

  HomeBottomsheetInformation({
    Key? key,
    required this.informationTitle,
    required this.photoList,
    required this.descriptionContent,
    required this.programId,
  }) : super(key: key);

  final HomePageController _homePageController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_homePageController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else {
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
                child: photoList.isEmpty
                    ? Shimmer(
                        duration: Duration(seconds: 2),
                        color: Colors.grey.shade400,
                        enabled: true,
                        child: Container(),
                      )
                    : GestureDetector(
                        onTap: () {
                          _showFullScreenImage(context, photoList);
                        },
                        child: Container(
                          height: heightScreen,
                          width: widthScreen * 0.5,
                          child: Padding(
                            padding: const EdgeInsets.all(1),
                            child: Image.network(
                              'https://talentaku.site/image/program/$photoList',
                              fit: BoxFit.scaleDown,
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
                      ),
              ),
              SizedBox(height: 20),
              Flexible(
                child: Text(descriptionContent, style: AppTextStyle.tsNormal),
              ),
              SizedBox(height: 20),
              Obx(() {
                if (_homePageController.userRole
                    .any((role) => role.contains('Guru'))) {
                  return Row(
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
                            color: AppColor.blue600,
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
                      SizedBox(width: Get.width * 0.08),
                      GestureDetector(
                        onTap: () async {
                          try {
                            await _homePageController.deleteProgram(programId);
                            Get.snackbar(
                                'Success', 'Program deleted successfully');
                          } catch (e) {
                            Get.snackbar(
                                'Error', 'Failed to delete program: $e');
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
                  );
                } else {
                  return SizedBox.shrink();
                }
              }),
            ],
          ),
        );
      }
    });
  }

  void _showEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
            color: AppColor.white,
          ),
          child: EditProgramPopup(
            programId: programId,
            initialName: informationTitle,
            initialDesc: descriptionContent,
            initialPhoto: photoList.isNotEmpty ? photoList[0] : '',
            initialCategoryId: 1,
          ),
        );
      },
    );
  }

  void _showFullScreenImage(BuildContext context, String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenImage(imageUrl: imageUrl),
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  FullScreenImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Image.network(
            'https://talentaku.site/image/program/$imageUrl',
            fit: BoxFit.contain,
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
    );
  }
}
