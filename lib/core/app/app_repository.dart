import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';

import '../../data/graphql/subscriptions.dart';
import '../../data/models/message.dart';
import '../services/notifications.dart';

class AppRepository extends GetxService {
  final HasuraConnect connection;
  Snapshot? currentSnapshot;

  AppRepository(this.connection);

  Future<void> handleNewMessage(dynamic json) async {
    final messages = json["data"]["messages"] as List<dynamic>;
    final message = MessageModel.fromJsonList(messages)!.first;
    // Show local notification for the new message
    await FlutterLocalNotification.showNotification(
      title: 'شما یک پیام جدید دارید',
      body: message.content!,
    );
  }

  Future<void> subscribeToNewMessages(String receiverId) async {
    currentSnapshot = await connection.subscription(
        newMessagesFormAllUsersSubscription,
        variables: {"receiverId": receiverId});
    currentSnapshot?.listen(handleNewMessage);
  }

  @override
  void onClose() {
    currentSnapshot?.close();
    super.onClose();
  }
}
