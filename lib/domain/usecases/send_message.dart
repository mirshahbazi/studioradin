import '../../data/repositories/chat_repository.dart';

class SendMessage {
  final ChatRepository repository;

  SendMessage(this.repository);

  Future<void> call(String receiverId, String content) async {
    return await repository.sendMessage(content, receiverId);
  }
}
