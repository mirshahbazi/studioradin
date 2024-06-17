import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studioradin/core/constants/images.dart';
import 'package:studioradin/core/constants/theme/styles.dart';

import '../../../core/components/src/image.dart';
import '../chat_history_logic.dart';

Widget userHeaderComponent(ChatHistoryLogic controller, context) {
  final size = MediaQuery.of(context).size;
  final double outerSize = size.width * 0.07;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      InkWell(
        radius: outerSize + 1,
        borderRadius: BorderRadius.circular(21),
        onTap: () {
          controller.isCollapsed.value = !controller.isCollapsed.value;
          controller.updateSearchVisibility(!controller.isSearching.value);
        },
        child: CircleAvatar(
          backgroundColor: Colors.white.withOpacity(0.1),
          radius: outerSize,
          child: image(searchIcon),
        ),
      ),
      InkWell(
          onTap: () {},
          child: CircleAvatar(
            backgroundColor: Colors.white.withOpacity(0.1),
            radius: outerSize,
            child: image(myAvatarIcon),
          )),
    ],
  ).marginOnly(top: 42, right: 16, left: 16);
}

Widget userHeaderComponentMock(ChatHistoryLogic controller, context) {
  final size = MediaQuery.of(context).size;
  final double outerSize = size.width * 0.07;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      InkWell(
        radius: outerSize + 1,
        borderRadius: BorderRadius.circular(21),
        onTap: () {
          controller.isCollapsed.value = !controller.isCollapsed.value;
          controller.updateSearchVisibility(!controller.isSearching.value);
        },
        child: CircleAvatar(
          backgroundColor: Styles.blue12,
          radius: outerSize,
          child: image(searchIcon),
        ),
      ),
      InkWell(
          onTap: () {},
          child: CircleAvatar(
            backgroundColor: Styles.blue12,
            radius: outerSize,
            child: image(myAvatarIcon),
          )),
    ],
  );
}
