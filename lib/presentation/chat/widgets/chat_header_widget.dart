import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studioradin/core/constants/images.dart';

import '../../../core/components/src/image.dart';
import '../../../core/constants/theme/styles.dart';
import '../../../core/widgets/double_bounce_indicator.dart';

class ChatHeaderWidget extends StatelessWidget {
  final String userImagePath;
  final String userName;

  const ChatHeaderWidget(
      {super.key, required this.userImagePath, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              IconButton(onPressed: () => Get.back(), icon: image(backIcon)),
              const SizedBox(width: 8.0),
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: CachedNetworkImage(
                  height: 50,
                  width: 50,
                  imageUrl: userImagePath,
                  placeholder: (context, url) =>
                      const DoubleBounceLoadingIndicator(),
                  errorWidget: (context, url, error) => image(avatarIcon),
                ),
              ),
              const SizedBox(width: 8.0),
              Text(
                userName,
                style: Styles.bigText(color: Styles.black6),
              ),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              InkWell(
                onTap: () => {},
                child: image(videosIcon),
              ),
              const SizedBox(width: 16.0),
              InkWell(
                onTap: () => {},
                child: image(voiceCallIcon),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
