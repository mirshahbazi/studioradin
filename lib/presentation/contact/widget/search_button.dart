import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studioradin/core/constants/theme/styles.dart';

import '../../../core/constants/string.dart';
import '../contact_logic.dart';

Widget searchBarComponent(ContactLogic controller) {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Styles.grey31, // Border color
        width: 1.0, // Border width
      ),
      borderRadius:
          BorderRadius.circular(25.0), // Border radius for rounded corners
    ),
    child: TextField(
      cursorColor: Styles.blue13,
      style: Styles.normalText(),
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
      onChanged: (val) {
        controller.updateSearchText(val);
      },
      decoration: InputDecoration(
        hintText: searchUserTxt,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        suffixIcon: const Icon(
          Icons.search,
          color: Styles.blue13,
        ),
        prefixIcon: InkWell(
          onTap: () {
            controller.updateSearchVisibility(!controller.isSearching.value);
          },
          child: const Icon(
            Icons.close,
            color: Styles.blue13,
          ),
        ),
      ),
    ),
  ).marginOnly(right: 16, left: 16, top: 36, bottom: 20);
}
