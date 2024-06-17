import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:studioradin/core/constants/images.dart';
import 'package:studioradin/data/models/message.dart';

import '../../../../core/components/src/image.dart';
import '../../../../core/constants/theme/styles.dart';
import '../../../../core/widgets/double_bounce_indicator.dart';
import 'message_blob_clipper.dart';

class MessageBlobComponent extends StatelessWidget {
  final bool me;
  final MessageModel message;

  const MessageBlobComponent({
    super.key,
    required this.me,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: me ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: <Widget>[
        if (me)
          Padding(
            padding: const EdgeInsets.only(right: 7, left: 10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: image(
                myAvatarIcon,
                height: 50,
                width: 50,
              ),
            ),
          ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          alignment: me ? Alignment.topRight : Alignment.topLeft,
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.65,
            child: ClipPath(
              clipper: MessageClipper(me: me),
              child: Container(
                color: me ? Styles.green11 : Styles.pink5,
                padding: EdgeInsets.fromLTRB(me ? 9 : 19, 6, me ? 17 : 7, 3),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (!me && message.user != null)
                      // Text(
                      //   "${message.user?.fullName}",
                      //   style:
                      //       const TextStyle(fontSize: 12, color: Styles.black6),
                      // ),
                      const SizedBox(height: 5),
                    Align(
                      alignment:
                          me ? Alignment.centerRight : Alignment.centerLeft,
                      child: Text(
                        message.content ?? 'N/A',
                        style: Styles.smallText(color: Styles.black6),
                      ),
                    ),

                    /// date time
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          image(checkDoubleIcon, height: 12)
                              .marginOnly(left: 6),
                          Text(
                            message.createdAt != null
                                ? DateFormat('HH:mm')
                                    .format(message.createdAt!.toLocal())
                                : '',
                            style: Styles.normalText(
                                color: Styles.grey28, size: 10),
                          ),
                        ],
                      ),
                    ).marginOnly(top: 8),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (!me)
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 7),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: message.user!.profilePicture.isEmpty
                  ? image(
                      avatarIcon,
                      height: 50,
                      width: 50,
                    )
                  : CachedNetworkImage(
                      height: 50,
                      width: 50,
                      imageUrl: message.user!.profilePicture,
                      placeholder: (context, url) =>
                      const DoubleBounceLoadingIndicator(),
                      errorWidget: (context, url, error) => image(avatarIcon),
                    ),
            ),
          ),
      ],
    );
  }
}
