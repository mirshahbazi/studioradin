import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';

import '../../../data/models/contact_model.dart';
import '../chat_history_logic.dart';
import 'search_item.dart';
import 'user_item_component.dart';

Widget userListComponent(ChatHistoryLogic controller, ContactModel list) {
  final filteredList = searchItem(controller, list);
  return ListView.separated(
    scrollDirection: Axis.horizontal,
    separatorBuilder: (ctx, i) => const SizedBox(height: 16),
    padding: const EdgeInsets.all(20),
    physics: const BouncingScrollPhysics(),
    itemCount: filteredList!.length,
    itemBuilder: (context, index) => AnimatedSizeAndFade(
        fadeDuration: const Duration(milliseconds: 250),
        sizeDuration: const Duration(milliseconds: 250),
        child: userItemComponent(controller, filteredList[index])),
  );
}
