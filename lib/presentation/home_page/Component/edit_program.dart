import 'package:flutter/material.dart';
import 'package:flutter_talentaku/infrastructure/theme/theme.dart';
import 'package:get/get.dart';

import '../controllers/home_page.controller.dart';

class EditProgramPopup extends StatelessWidget {
  final int programId;
  final String initialName;
  final String initialDesc;
  final String initialPhoto;
  final int initialCategoryId;

  EditProgramPopup({
    required this.programId,
    required this.initialName,
    required this.initialDesc,
    required this.initialPhoto,
    required this.initialCategoryId,
  });

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController photoController = TextEditingController();
  final TextEditingController categoryIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = initialName;
    descController.text = initialDesc;
    photoController.text = initialPhoto;
    categoryIdController.text = initialCategoryId.toString();

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: descController,
                decoration: InputDecoration(labelText: "Description"),
              ),
              TextField(
                controller: photoController,
                decoration: InputDecoration(labelText: "Photo URL"),
              ),
              TextField(
                controller: categoryIdController,
                decoration: InputDecoration(labelText: "Category ID"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  try {
                    Get.find<HomePageController>().updateProgram(
                      programId,
                      nameController.text,
                      descController.text,
                      photoController.text,
                      int.parse(categoryIdController.text),
                    );
                    Navigator.of(context).pop();
                  } catch (e) {
                    print('Error: $e');
                  }
                },
                child: Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
