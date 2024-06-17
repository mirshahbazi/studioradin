import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studioradin/core/constants/theme/styles.dart';

import '../../core/components/src/image.dart';
import '../../core/constants/images.dart';
import '../../core/widgets/double_bounce_indicator.dart';
import 'chat_logic.dart';
import 'widgets/chat_header_widget.dart';
import 'widgets/date_separator.dart';
import 'widgets/message_blob/message_blob_component.dart';
import 'widgets/message_input_widget.dart';

class ChatPage extends GetView<ChatLogic> {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press
        Get.back(closeOverlays: true);
        return false; // Prevent the page from being destroyed
      },
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            height: double.infinity,
            child: SafeArea(child: ChatHeaderWidget(userImagePath: controller.chatUser.value?.profilePicture ?? '',userName: controller.chatUser.value?.fullName ?? '',)),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              color: Styles.white12,
              child: image(chatBackgroundIcon),
            ),
            Obx(
              () {
                if (controller.isLoadMore.value) {
                  return const Center(
                    child: DoubleBounceLoadingIndicator(),
                  );
                }
                return Column(
                  children: <Widget>[
                    Expanded(
                      child: ReorderableListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 1, vertical: 4),
                        physics: const BouncingScrollPhysics(),
                        scrollController: controller.scrollController,
                        itemCount: controller.itemsController.length,
                        reverse: true,
                        onReorder: (int old, int to) {
                          if (old < to) {
                            --to;
                          }
                          final item = controller.itemsController.removeAt(old);
                          controller.itemsController.insert(to, item);
                        },
                        itemBuilder: (context, index) {
                          final message = controller.itemsController[index];
                          bool isCurrentUser =
                              (controller.appBloc.currentUser.value!.id ==
                                  message.senderId);

                          Widget dateSeparator;
                          if (index == 0 ||
                              controller
                                      .itemsController[index].createdAt?.day !=
                                  controller.itemsController[index - 1]
                                      .createdAt?.day) {
                            dateSeparator = DateSeparator(
                                date: message.createdAt!.toLocal());
                          } else {
                            dateSeparator = const SizedBox.shrink();
                          }

                          return Column(
                            key: ValueKey(message.id),
                            children: [
                              dateSeparator,
                              AnimatedSizeAndFade(
                                fadeDuration: const Duration(milliseconds: 250),
                                sizeDuration: const Duration(milliseconds: 250),
                                child: MessageBlobComponent(
                                  key: ValueKey(message),
                                  me: isCurrentUser,
                                  message: message,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    MessageInputWidget(controller: controller),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
