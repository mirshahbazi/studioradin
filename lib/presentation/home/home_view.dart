import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:studioradin/core/components/index.dart';
import 'package:studioradin/core/constants/images.dart';
import 'package:studioradin/core/constants/public_const.dart';
import 'package:studioradin/core/constants/string.dart';
import 'package:studioradin/core/constants/theme/styles.dart';

import 'home_logic.dart';

class HomePage extends GetView<HomeLogic> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.white12,
      body: Obx(
        () => AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: controller.pages[controller.selectedIndex.value],
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            color: Colors.white, // Background color of the container
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(bottomBarRound),
              // Adjust the radius as needed
              topRight: Radius.circular(bottomBarRound),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03), // Shadow color
                spreadRadius: 2, // Spread radius
                blurRadius: 8, // Blur radius
                offset: const Offset(0, -1), // Offset in the x and y direction
              ),
            ],
          ),
          child: SalomonBottomBar(
            curve: Curves.easeInToLinear,
            backgroundColor: Colors.transparent,
            // Set to transparent to see the container background
            currentIndex: controller.selectedIndex.value,
            selectedItemColor: Styles.primaryColor,
            selectedColorOpacity: 0.1,
            onTap: controller.changeTabIndex,
            items: [
              /// chats
              SalomonBottomBarItem(
                icon: image(chatIcon,
                    color: Styles.secenderyColor.withOpacity(0.3)),
                title: const Text(
                  chatTxt,
                  style: TextStyle(
                    color: Styles.primaryColor,
                    fontFamily: appPersianFont,
                  ),
                ),
                activeIcon: image(chatIcon, color: Styles.primaryColor),
                selectedColor: Colors.white,
              ),

              /// users
              SalomonBottomBarItem(
                icon: image(userIcon,
                    color: Styles.secenderyColor.withOpacity(0.3)),
                activeIcon: image(userIcon, color: Styles.primaryColor),
                title: const Text(
                  usersTxt,
                  style: TextStyle(
                    color: Styles.primaryColor,
                    fontFamily: appPersianFont,
                  ),
                ),
                selectedColor: Colors.white,
              ),

              /// calls
              SalomonBottomBarItem(
                icon: image(callIcon,
                    color: Styles.secenderyColor.withOpacity(0.3)),
                activeIcon: image(callIcon, color: Styles.primaryColor),
                title: const Text(
                  callTxt,
                  style: TextStyle(
                    color: Styles.primaryColor,
                    fontFamily: appPersianFont,
                  ),
                ),
                selectedColor: Colors.white,
              ),

              /// settings
              SalomonBottomBarItem(
                icon: image(settingIcon,
                    color: Styles.secenderyColor.withOpacity(0.3)),
                activeIcon: image(settingIcon, color: Styles.primaryColor),
                title: const Text(
                  settingTxt,
                  style: TextStyle(
                    color: Styles.primaryColor,
                    fontFamily: appPersianFont,
                  ),
                ),
                selectedColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
