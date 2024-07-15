import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../infrastructure/theme/theme.dart';
import '../login_page/controllers/login.controller.dart';
import '../profile_page/model/user_model.dart';

class DefaultAppbar extends StatelessWidget {
  const DefaultAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final String username = box.read('username');
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 20, top: 4, bottom: 4),
        child: Image.asset('assets/images/logo_talentaku.png'),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Selamat Pagi, $username',
            style: AppTextStyle.tsNormal,
          ),
          Text(
            'Semangat buat hari ini yaa..',
            style: AppTextStyle.tsLittle,
          ),
        ],
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.message_rounded,
                size: 24,
              )),
        )
      ],
      backgroundColor: AppColor.background,
    );
  }
}
