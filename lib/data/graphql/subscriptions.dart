const String newMessagesFormAllUsersSubscription = """
subscription OnNewMessage(\$receiverId: uuid!) {
  messages(
    order_by: { created_at: desc },
    where: { receiver_id: { _eq: \$receiverId } },
    limit: 1
  ) {
    id
    content
    sender_id
    receiver_id
    created_at
  }
}
""";

const onNewMessageFromOneUserSubscription = '''
  subscription OnNewMessage(\$userId1: uuid!, \$userId2: uuid!, \$limit: Int!) {
    messages(
      order_by: {created_at: desc}, 
      limit: \$limit
      where: {
        _or: [
          { _and: [{ sender_id: { _eq: \$userId1 } }, { receiver_id: { _eq: \$userId2 } }] },
          { _and: [{ sender_id: { _eq: \$userId2 } }, { receiver_id: { _eq: \$userId1 } }] }
        ]
      }
    ) {
      id
      content
      sender_id
      receiver_id
      created_at
      updated_at
    }
  }
''';
