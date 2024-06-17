import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart';
import 'package:studioradin/core/app/app_controller.dart';

import '../../data/graphql/mutations.dart';
import '../../data/models/message.dart';
import '../graphql/subscriptions.dart';

class ChatRepository {
  final HasuraConnect connection;
  Snapshot? currentSnapshot;
  final appController = Get.find<AppController>();
  bool isSubscriptionActive = false;

  ChatRepository(this.connection);

  Future<Snapshot<List<MessageModel>?>?> updateRequest( String receiverId,int limit,) async {
    if (!isSubscriptionActive) {
     return null;
    }
      try {
        currentSnapshot?.changeVariables({
          "userId1": appController.currentUser.value?.id,
          'userId2': receiverId,
          'limit': limit,
        });
        return currentSnapshot!.map((json) {
          final messages = json["data"]["messages"] as List<dynamic>;
          return MessageModel.fromJsonList(messages);
        });
      } catch (e) {
        isSubscriptionActive = false; // Ensure subscription status is inactive on failure
        rethrow; // Optionally, handle the error as needed
      }


  }

  void setLimit(int limit) =>
      currentSnapshot?.changeVariables({"limit": limit});

  void closeConnection() {
    currentSnapshot?.closeConnection;
    connection.disconnect();
    isSubscriptionActive = false; // Reset the subscription status when closed
  }

  Future<Stream<List<MessageModel>?>> getMessages(String receiverId, int limit ) async {

      try {
        currentSnapshot =
            await connection.subscription(onNewMessageFromOneUserSubscription, variables: {
          "userId1": appController.currentUser.value?.id,
          'userId2': receiverId,
          'limit': limit,
        });
        isSubscriptionActive = true; // Set the subscription status to active
        return currentSnapshot!.map((json) {
          final messages = json["data"]["messages"] as List<dynamic>;
          return MessageModel.fromJsonList(messages);
        });
      } catch (e) {
        isSubscriptionActive = false; // Ensure subscription status is inactive on failure
        rethrow; // Optionally, handle the error as needed
      }
  }

  Future<void> sendMessage(String message, String receiverId) async {
    await connection.mutation(
      sendMessageMutation,
      variables: {
        'senderId': appController.currentUser.value?.id,
        'receiverId': receiverId,
        'content': message,
      },
    );
  }
}
