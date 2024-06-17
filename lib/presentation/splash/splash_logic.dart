import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../home/home_view.dart';

class SplashLogic extends GetxController with SingleGetTickerProviderMixin {
  late AnimationController animationController;
  late Animation<double> animation;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );

    animationController.forward();

    // Navigate to the main page after the animation completes
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Get.off(const HomePage());
      }
    });
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
