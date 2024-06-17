import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:studioradin/core/components/src/image.dart';
import 'package:studioradin/core/constants/images.dart';

import '../../core/constants/public_const.dart';
import '../../core/widgets/double_bounce_indicator.dart';
import 'chat_history_logic.dart';
import 'widgets/chat_history_item_widget.dart';
import 'widgets/header_widget.dart';
import 'widgets/user_list_component.dart';

class ChatHistoryPage extends GetView<ChatHistoryLogic> {
  const ChatHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.loadData();
    return Obx(() {
      return Stack(
        children: [
          SizedBox(
            height: !controller.isCollapsed.value
                ? MediaQuery.of(context).size.height * 0.4
                : 0,
            child: Stack(
              children: [
                image(splashBackgroundIcon,
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth),
                !controller.isCollapsed.value
                    ? userHeaderComponent(controller, context)
                    : Container(),
                controller.isLoading.value
                    ? const Center(child: DoubleBounceLoadingIndicator())
                    : controller.users.value != null
                        ? userListComponent(controller, controller.users.value!)
                            .marginOnly(
                                top: MediaQuery.of(context).size.width * 0.26)
                        : Container(),
              ],
            ),
          ),
          Column(
            children: [
              Visibility(
                visible: controller.isCollapsed.value,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: controller.isCollapsed.value
                        ? BorderRadius.zero
                        : const BorderRadius.vertical(
                            top: Radius.circular(bottomBarRound),
                          ),
                  ),
                  padding: const EdgeInsets.all(bottomBarRound),
                  child: userHeaderComponentMock(controller, context),
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: controller.isCollapsed.value
                        ? BorderRadius.zero
                        : const BorderRadius.vertical(
                            top: Radius.circular(bottomBarRound),
                          ),
                  ),
                  padding: const EdgeInsets.all(bottomBarRound),
                  child: AnimationLimiter(
                    child: ListView.builder(
                      itemCount: controller.messages.length,
                      itemBuilder: (context, index) {
                        final message = controller.messages[index];
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            horizontalOffset: 50,
                            child: FadeInAnimation(
                              child: AnimatedSizeAndFade(
                                fadeDuration: const Duration(milliseconds: 250),
                                sizeDuration: const Duration(milliseconds: 250),
                                child: ChatsMessageWidget(
                                  id: message.id,
                                  imageUrl: message.imageUrl,
                                  fullName: message.fullName,
                                  message: message.message,
                                  dateTime: message.dateTime,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                ),
              ),
            ],
          ).marginOnly(
            top: !controller.isCollapsed.value
                ? MediaQuery.of(context).size.height * 0.3
                : 30,
          )
        ],
      );
    });
  }
}
