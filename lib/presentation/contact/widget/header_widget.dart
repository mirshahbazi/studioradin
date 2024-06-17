import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studioradin/core/constants/images.dart';

import '../../../core/components/src/image.dart';
import '../../../core/constants/theme/styles.dart';
import '../contact_logic.dart';

Widget userHeaderComponent(ContactLogic controller, context) {
  final size = MediaQuery.of(context).size;
  final double outerSize = size.width * 0.07;
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      InkWell(
        radius: outerSize + 1,
        borderRadius: BorderRadius.circular(21),
        onTap: () {
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
  ).marginOnly(top: 40, right: 16, left: 16);
}
