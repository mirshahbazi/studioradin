import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/images.dart';
import 'splash_logic.dart';

class SplashPage extends GetView<SplashLogic> {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            splashBackgroundIcon,
            fit: BoxFit.cover,
          ),
          // Animated logo
          Center(
            child: ScaleTransition(
              scale: controller.animation,
              child: Image.asset(
                logoIcon,
                width: 250,
                height: 250,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
