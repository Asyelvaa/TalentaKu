import 'package:flutter/material.dart';
import 'package:flutter_talentaku/presentation/home_page/home_page.screen.dart';
import 'package:flutter_talentaku/presentation/profile_page/profile_page.screen.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../infrastructure/theme/theme.dart';
import '../class_page/class_page.screen.dart';

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
              icon: Icon(Iconsax.home),
              selectedIcon: Icon(
                Iconsax.home,
                color: AppColor.blue500,
              ),
              // New line: selected icon
              label: "Home",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.book_14),
              selectedIcon: Icon(
                Iconsax.book_14,
                color: AppColor.blue500,
              ),
              // New line: selected icon
              label: "Class",
            ),
            NavigationDestination(
              icon: Icon(Iconsax.profile_circle4),
              selectedIcon: Icon(
                Iconsax.profile_circle5,
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
