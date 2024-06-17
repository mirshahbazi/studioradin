import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:studioradin/core/constants/theme/styles.dart';
import 'package:studioradin/data/models/chats_model.dart';

import '../../core/constants/string.dart';
import '../../core/services/storage_services.dart';
import '../../data/models/chat_message.dart';
import '../../data/models/contact_model.dart';
import '../../data/models/user.dart';
import '../../domain/usecases/get_users.dart';
import 'chat_history_state.dart';

class ChatHistoryLogic extends GetxController {

  final ChatHistoryState state = ChatHistoryState();
  final storage = GetStorage();


  final GetUsers userUseCase;
  // var userList = <UserModel>[].obs;
  var chatHistory = <ChatMessage>[].obs;

  RxBool isSearching = false.obs;
  RxBool isCollapsed = false.obs;
  RxString searchText = ''.obs;

  Rx<ContactModel?> users = Rx<ContactModel?>(null);
  var isLoading = false.obs;


  final StorageService storageService = StorageService();
  var messages = <ChatsModel>[].obs;

  ChatHistoryLogic({required this.userUseCase});

  void loadData(){
    fetchUsers();
    fetchChatHistory();
  }
  // void fetchUsers() {
  //   // Fetch user list from storage or API
  //   var storedUsers = storage.read<List>('users') ?? [];
  //   userList.value = storedUsers.map((e) => UserModel.fromJson(e)).toList();
  // }

  void addMessage(ChatsModel message) {
    messages.add(message);
    storageService.updateMessage(message);
  }

  void fetchUsers() async {
    isLoading.value = true;
    try {
      users.value = (await userUseCase.call());
    } finally {
      isLoading.value = false;
    }
  }

  void updateSearchVisibility(bool state) {
    isSearching.value = state;
  }


  void fetchChatHistory() {
    messages.value = storageService.loadMessages();
    // Fetch chat history from storage or API
    var storedChats = storage.read<List>('chatHistory') ?? [];
    chatHistory.value =
        storedChats.map((e) => ChatMessage.fromJson(e)).toList();
  }

  void addUser(UserModel user) {
    users.value?.users?.add(user);
    // storage.write('users', users.map((e) => e!.users.()).toList());
  }

  // void addMessage(ChatMessage message) {
  //   chatHistory.add(message);
  //   storage.write('chatHistory', chatHistory.map((e) => e.toJson()).toList());
  // }

  List<ChatMessage> getChatHistoryForUser(String userId) {
    return chatHistory.where((message) => message.userId == userId).toList();
  }

  void showDeleteConfirmationDialog(BuildContext context,String messageId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(deleteChatsTxt,style: Styles.bigTextW500(),),
          content: Text(areYouSureDeleteChatsTxt,style: Styles.normalTextW500(),),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(cancelTxt,style: Styles.bigTextW500(color: Styles.green5),),
            ),
            TextButton(
              onPressed: () async {
                storageService.deleteMessage(messageId);
                fetchChatHistory();
                update();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(deleteTxt,style: Styles.bigTextW500(color: Styles.red5),),
            ),
          ],
        );
      },
    );
  }
}
