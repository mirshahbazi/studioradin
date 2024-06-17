import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';

import '../../core/app/app_controller.dart';
import '../../data/repositories/chat_repository.dart';
import '../../domain/usecases/get_messages_from_user.dart';
import '../../domain/usecases/send_message.dart';
import 'chat_logic.dart';

class ChatBinding extends Bindings {
  @override
  void dependencies() {
    final chatRepository = ChatRepository(Get.find<HasuraConnect>());
    final sendMessageUseCase = SendMessage(chatRepository);
    final getMessageUseCase = GetMessagesFromUser(chatRepository);
    // Get.lazyPut<ChatLogic>(() => ChatLogic(sendMessageUseCase, getMessageUseCase, Get.find<AppController>()));

    Get.put(ChatLogic(sendMessageUseCase, getMessageUseCase, Get.find<AppController>()), permanent: false);
  }
}
