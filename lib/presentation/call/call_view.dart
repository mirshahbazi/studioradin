import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'call_logic.dart';

class CallPage extends StatelessWidget {
  const CallPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<CallLogic>();
    final state = Get.find<CallLogic>().state;

    return Container();
  }
}
