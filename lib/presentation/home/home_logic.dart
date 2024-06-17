import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../call/call_view.dart';
import '../chat_history/chat_history_view.dart';
import '../contact/contact_view.dart';
import '../setting/setting_view.dart';
import 'home_state.dart';

class HomeLogic extends GetxController {
  final HomeState state = HomeState();

  var selectedIndex = 0.obs;

  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }

  final List<Widget> pages = [
    const ChatHistoryPage(),
    const ContactPage(),
    const CallPage(),
    const SettingPage(),
  ];

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
