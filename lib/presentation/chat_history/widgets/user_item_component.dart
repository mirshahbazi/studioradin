import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studioradin/core/constants/theme/styles.dart';
import 'package:studioradin/data/models/chats_model.dart';

import '../../../core/app/app_controller.dart';
import '../../../core/components/src/image.dart';
import '../../../core/constants/images.dart';
import '../../../core/routes/routes.dart';
import '../../../core/widgets/double_bounce_indicator.dart';
import '../../../data/models/user.dart';
import '../chat_history_logic.dart';


Widget userItemComponent(ChatHistoryLogic controller, UserModel user) {
  // bool itemSelected = controller.selectionList.contains(user.id);
  return InkWell(
    onTap: () {

      //  adding a new message to chats list
      Get.find<AppController>().addMessage(
        ChatsModel(
          id: user.id,
          imageUrl: user.profilePicture,
          fullName: user.fullName,
          message: '...',
          dateTime: DateTime.now(),
        ),
      );
      controller.fetchChatHistory;

      // show the chat page
      Get.toNamed(Routes.chat,
          arguments:  user);
    },
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
    Container(
    width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Styles.cyan8, width: 2.0),
      ),

          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: CachedNetworkImage(
              height: 50,
              width: 50,
              imageUrl: user.profilePicture,
              placeholder: (context, url) =>  const DoubleBounceLoadingIndicator(),
              errorWidget: (context, url, error) => image(avatarIcon),
            ),
          ),
        ),
        Text(
          user.fullName,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.normal,
            fontSize: 16,
          ),
        ).marginOnly(right: 16.0,left: 16.0,top: 6),

      ],
    ),
  );
}
