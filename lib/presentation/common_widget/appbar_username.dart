import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../infrastructure/theme/theme.dart';

class AppbarUsername extends StatelessWidget {
  const AppbarUsername({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final username = GetStorage().read('dataUser')?['username'];

    return AppBar(
      leading: IconButton(
        icon: Icon(Icons.arrow_back_rounded, color: AppColor.blue600),
        onPressed: () {
          Get.back();
        },
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profile, $username',
            style: AppTextStyle.tsTitle,
          ),
        ],
      ),
      backgroundColor: AppColor.background,
    );
  }
}
