import 'package:studioradin/data/models/message.dart';

import '../../data/repositories/chat_repository.dart';

class GetMessagesFromUser {
  final ChatRepository repository;

  GetMessagesFromUser(this.repository);

  Future<Stream<List<MessageModel>?>> call(String receiverId,int count) async {
    return await repository.getMessages(receiverId,count);
  }

  Future<Stream<List<MessageModel>?>?> update(String receiverId,int count) async {
    return await repository.updateRequest(receiverId,count);
  }


  Future<void> closeConnection()async{
    return repository.closeConnection();
  }

  Future<void> setLimit(int limit)async{
    return repository.setLimit(limit);
  }

}
