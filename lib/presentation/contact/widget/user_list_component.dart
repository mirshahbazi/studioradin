import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../data/models/contact_model.dart';
import '../contact_logic.dart';
import 'search_item.dart';
import 'user_item_component.dart';

Widget userListComponent(ContactLogic controller, ContactModel list) {
  final filteredList = searchItem(controller, list);
  return ListView.separated(
    separatorBuilder: (ctx, i) => const SizedBox(height: 16),
    padding: const EdgeInsets.all(20),
    physics: const BouncingScrollPhysics(),
    itemCount: filteredList!.length,
    itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        horizontalOffset: 50,
        child: FadeInAnimation(
          child: AnimatedSizeAndFade(
            fadeDuration: const Duration(milliseconds: 250),
            sizeDuration: const Duration(milliseconds: 250),
            child: userItemComponent(controller, filteredList[index]),
          ),
        ),
      ),
    ),
  );
}
