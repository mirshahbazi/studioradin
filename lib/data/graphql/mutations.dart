
const String sendMessageMutation = r'''
mutation SendMessage($senderId: uuid!, $receiverId: uuid!, $content: String!) {
  insert_messages(objects: {sender_id: $senderId, receiver_id: $receiverId, content: $content}) {
    returning {
      id
      sender_id
      receiver_id
      content
      created_at
    }
  }
}
''';

