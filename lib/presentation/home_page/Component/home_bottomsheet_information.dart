import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'edit_program.dart';
import '../controllers/home_page.controller.dart';

class HomeBottomsheetInformation extends StatelessWidget {
  final String informationTitle;
  final List<String> photoList;
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
                        child: Image.network(
                          photoList[index],
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
                style: AppTextStyle.tsNormal
                    .copyWith(fontWeight: FontWeight.normal),
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
                borderRadius: BorderRadius.circular(12),
              ),
              minimumSize: Size(double.infinity, 50), // Button size
            ),
            child: Text('Kembali',
                style: AppTextStyle.tsNormal
                    .copyWith(fontWeight: FontWeight.bold)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _showEditPopup(context),
                child: Container(
                  height: 50,
                  width: 100,
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
                width: 20,
              ),
              GestureDetector(
                onTap: () async {
                  try {
                   await _homePageController.deleteProgram(programId);
                    // Beri notifikasi atau perbarui UI setelah sukses
                    Get.snackbar('Success', 'Program deleted successfully');
                  } catch (e) {
                    // Tampilkan pesan kesalahan
                    Get.snackbar('Error', 'Failed to delete program: $e');
                  }
                },
                child: Container(
                  height: 50,
                  width: 100,
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

  void _showEditPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditProgramPopup(
          programId: programId,
          initialName: informationTitle,
          initialDesc: descriptionContent,
          initialPhoto: photoList.isNotEmpty ? photoList[0] : '',
          initialCategoryId: 1,
        );
      },
    );
  }
}
