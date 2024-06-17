import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/widgets/double_bounce_indicator.dart';
import 'contact_logic.dart';
import 'widget/header_widget.dart';
import 'widget/search_button.dart';
import 'widget/user_list_component.dart';

class ContactPage extends GetView<ContactLogic> {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    controller.fetchUsers();
    return Scaffold(
      body: Column(
        children: [
          Obx(() {
            if (controller.isSearching.value) {
              return searchBarComponent(controller);
            }
            return userHeaderComponent(controller, context);
          }),

          // User List
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: DoubleBounceLoadingIndicator());
              }
              return userListComponent(controller, controller.users.value!);
            }),
          ),
        ],
      ),
    );
  }
}
