import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:studioradin/data/models/chats_model.dart';
import 'package:studioradin/data/repositories/chat_repository.dart';

import '../../core/app/app_controller.dart';
import '../../data/models/message.dart';
import '../../data/models/user.dart';
import '../../domain/usecases/get_messages_from_user.dart';
import '../../domain/usecases/send_message.dart';

class ChatLogic extends GetxController {
  final SendMessage sendMessageUseCase;
  final GetMessagesFromUser getMessagesFromUser;
  final AppController appBloc;
  final edtController = TextEditingController();
  final scrollController = ScrollController();
  var count = 60.obs;
  RxBool moreController = false.obs;
  var itemsController = <MessageModel>[].obs;
  var isLoadMore = false.obs;
  StreamSubscription<List<MessageModel>?>? messagesSubscription;
  Rx<UserModel?> chatUser = Rx<UserModel?>(null);

  ChatLogic(this.sendMessageUseCase, this.getMessagesFromUser, this.appBloc) {
    initializeMessagesOut();

    scrollController.addListener(() {
      // Check if the user has scrolled to the bottom (which is actually the top due to reverse: true)
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          moreController.value) {
        // Load more messages when user scrolls to the bottom (top of the reversed list)
        count.value += 20;
        loadMoreMessages();
      }
    });
  }

  void initializeMessagesOut() async {
    UserModel? user = Get.arguments;
    chatUser.value = user!;
    isLoadMore.value = true;
    final messagesStream =
        await getMessagesFromUser.call(chatUser.value!.id, count.value);
    messagesSubscription = messagesStream.listen((data) {
      isLoadMore.value = false;

      if(data != null){
        itemsController.assignAll(data);
        updateChatsMessage(data.first.content!);
      }
      if (!moreController.value) {
        moreController.value = count.value <= data!.length;
        count.value += 20;
      }
    });
  }

  void loadMoreMessages() async {
    isLoadMore.value = true;
    final messagesStream =
        await getMessagesFromUser.update(chatUser.value!.id, count.value);
    messagesSubscription = messagesStream?.listen((data) {
      isLoadMore.value = false;
      itemsController.addAll(data!);
      if (data.isEmpty) {
        moreController.value = false;
        updateChatsMessage(data.first.content!);

      }
    });
  }

  void sendMessage() async {
    if (edtController.text.trim().isNotEmpty) {
      var newList = List<MessageModel>.from(itemsController);
      newList.add(
        MessageModel(
          content: edtController.text.trim(),
          user: appBloc.currentUser.value!,
          id: '',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          receiverId: '',
          senderId: '',
        ),
      );

      itemsController.assignAll(newList);

      sendMessageUseCase.call(chatUser.value!.id, edtController.text.trim());
      updateChatsMessage(edtController.text.trim());
      await Future.delayed(const Duration(milliseconds: 300));
      edtController.clear();
    }
  }

  void updateChatsMessage(String messages) {
    //  adding a new message to chats list
    Get.find<AppController>().addMessage(
      ChatsModel(
        id: chatUser.value!.id,
        imageUrl: chatUser.value!.profilePicture,
        fullName: chatUser.value!.fullName,
        message: messages,
        dateTime: DateTime.now(),
      ),
    );
  }

  void toggleDarkMode() {
    appBloc.darkMode.value = !appBloc.darkMode.value;
  }

  @override
  void onClose() {
    getMessagesFromUser.closeConnection();
    moreController.close();
    itemsController.close();
    edtController.dispose();
    messagesSubscription?.cancel();
    Get.delete<ChatRepository>();
    super.onClose();
  }
}
