import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/grade_page/class_page.screen.dart';
import 'package:flutter_talentaku/presentation/home_page/home_page.screen.dart';
import 'package:flutter_talentaku/presentation/profile_page/profile_page.screen.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../infrastructure/theme/theme.dart';

class NavbarMenu extends StatelessWidget {
  const NavbarMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          backgroundColor: AppColor.background,
          indicatorColor: Colors.transparent,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          destinations: const [
            NavigationDestination(
              icon: Icon(Iconsax.home_11),
              selectedIcon: Icon(
                Iconsax.home_11,
                color: AppColor.blue500,
              ),
              // New line: selected icon
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.book_11),
              selectedIcon: Icon(
                Iconsax.book_11,
                color: AppColor.blue500,
              ),
              // New line: selected icon
              label: "Class",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.profile_2user),
              selectedIcon: Icon(
                Iconsax.profile_2user,
                color: AppColor.blue500,
              ),
              // New line: selected icon
              label: "Profile",
            ),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    HomePageScreen(),
    ClassScreen(),
    ProfilePageScreen(),
  ];
}
