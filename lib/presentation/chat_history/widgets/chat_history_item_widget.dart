import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:time_ago_provider/time_ago_provider.dart' as time_ago;

import '../../../core/components/src/image.dart';
import '../../../core/constants/images.dart';
import '../../../core/constants/theme/styles.dart';
import '../../../core/routes/routes.dart';
import '../../../core/widgets/double_bounce_indicator.dart';
import '../../../data/models/user.dart';
import '../chat_history_logic.dart';

class ChatsMessageWidget extends StatelessWidget {
  final String id;
  final String imageUrl;
  final String fullName;
  final String message;
  final DateTime dateTime;

  const ChatsMessageWidget({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.fullName,
    required this.message,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<ChatHistoryLogic>();
    // Ensure the Persian locale is used
    time_ago.Persian();

    // Format the datetime in Persian
    String formattedTime = time_ago.format(dateTime, locale: 'fa');

    return InkWell(
      onTap: () {
        Get.toNamed(Routes.chat,
            arguments: UserModel(
                id: id,
                fullName: fullName,
                profilePicture: imageUrl,
                createdAt: DateTime.now(),
                email: '',
                updatedAt: DateTime.now()));
      },
      onLongPress: () {
        logic.showDeleteConfirmationDialog(context, id);
      },
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Avatar
            Container(
              margin: const EdgeInsets.only(left: 10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: CachedNetworkImage(
                  height: 60,
                  width: 60,
                  imageUrl: imageUrl,
                  placeholder: (context, url) =>
                  const DoubleBounceLoadingIndicator(),
                  errorWidget: (context, url, error) => image(avatarIcon),
                ),
              ),
            ),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fullName,
                    style: Styles.bigText(color: Styles.black6,size: 16),
                  ),
                  const SizedBox(height: 5.0),
                  Text(message,style: Styles.normalText(color: Styles.secenderyColor ),),
                ],
              ),
            ),
            // Circular Image
            // DateTime
            Container(
              margin: const EdgeInsets.only(right: 10.0),
              child: Text(
                formattedTime,
                style: const TextStyle(fontSize: 12.0, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
