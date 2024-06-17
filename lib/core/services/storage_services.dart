import 'package:get_storage/get_storage.dart';
import '../../data/models/chats_model.dart';

class StorageService {
  final GetStorage _box = GetStorage();

  Future<void> saveMessages(List<ChatsModel> messages) async {
    await _box.write('messages', messages.map((msg) => msg.toJson()).toList());
  }

  List<ChatsModel> loadMessages() {
    List<dynamic> jsonList = _box.read('messages') ?? [];
    List<ChatsModel> messages = jsonList.map((json) => ChatsModel.fromJson(json)).toList();
    messages.sort((a, b) => b.dateTime.compareTo(a.dateTime)); // Sorting by dateTime in descending order
    return messages;
  }

  Future<void> updateMessage(ChatsModel updatedMessage) async {
    final List<ChatsModel> messages = loadMessages();
    int existingIndex = messages.indexWhere((msg) => msg.id == updatedMessage.id);
    if (existingIndex != -1) {
      messages[existingIndex] = updatedMessage;
    } else {
      messages.add(updatedMessage);
    }
    await saveMessages(messages);
  }

  Future<void> deleteMessage(String id) async {
    final List<ChatsModel> messages = loadMessages();
    messages.removeWhere((msg) => msg.id == id);
    await saveMessages(messages);
  }
}
