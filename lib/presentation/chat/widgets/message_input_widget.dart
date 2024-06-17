import 'package:flutter/material.dart';
import 'package:studioradin/core/constants/images.dart';
import 'package:studioradin/core/constants/theme/styles.dart';

import '../../../core/components/src/image.dart';
import '../../../core/constants/string.dart';
import '../../chat_history/chat_history_logic.dart';
import '../chat_logic.dart';

class MessageInputWidget extends StatelessWidget {
  final ChatLogic? controller;
  const MessageInputWidget({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              top: BorderSide(width: 1, color: Styles.grey27.withOpacity(0.3)))
      ),
      child: Row(
        children: [
          const Icon(
            Icons.add,
            color: Colors.grey,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Styles.grey29,
                // Change this to your desired background color
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: TextField(
                controller: controller?.edtController,
                keyboardType: TextInputType.multiline,
                textAlign: TextAlign.right,
                decoration: const InputDecoration(
                  hintText: messageTxt, // Placeholder text
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
          ),
          IconButton(onPressed: () {
            controller?.sendMessage();
          }, icon: image(sendIcon)),
        ],
      ),
    );
  }
}
