import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studioradin/core/app/app_controller.dart';
import 'package:studioradin/core/constants/theme/styles.dart';
import 'package:studioradin/data/models/chats_model.dart';

import '../../../core/components/src/image.dart';
import '../../../core/constants/images.dart';
import '../../../core/routes/routes.dart';
import '../../../core/widgets/double_bounce_indicator.dart';
import '../../../data/models/user.dart';
import '../contact_logic.dart';

Widget userItemComponent(ContactLogic controller, UserModel user) {
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

      Get.toNamed(Routes.chat, arguments: user);
    },
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: CachedNetworkImage(
            height: 50,
            width: 50,
            imageUrl: user.profilePicture,
            placeholder: (context, url) => const DoubleBounceLoadingIndicator(),
            errorWidget: (context, url, error) => image(avatarIcon),
          ),
        ),
        Text(
          user.fullName,
          textAlign: TextAlign.center,
          style: Styles.bigText(color: Styles.black6, size: 16),
        ).marginOnly(right: 16.0),
      ],
    ),
  );
}
