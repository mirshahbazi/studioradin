
const String getMessagesQuery = r'''
  query GetMessages($limit: Int!, $offset: Int!) {
    messages(limit: $limit, offset: $offset) {
      id
      sender_id
      receiver_id
      content
      created_at
    }
  }
''';

const String getMessagesFromUserQuery = r'''
      query GetMessagesFromUser(\$userId: uuid!, \$limit: Int!, \$offset: Int!) {
        messages(where: {_or: [{sender_id: {_eq: \$userId}}, {receiver_id: {_eq: \$userId}}]}, limit: \$limit, offset: \$offset, order_by: {created_at: desc}) {
          id
          sender_id
          receiver_id
          content
          created_at
        }
      }
    ''';

String getUserQuery = """
query GetUsers {
  users {
     id
      email
      full_name
      profile_picture
      created_at
      updated_at
  }
}
""";

const String getUsersQuery = r'''
  query GetUsers {
    users {
      id
      email
      full_name
      profile_picture
      created_at
      updated_at
    }
  }
''';


const String getMessagesBetweenUsersQuery = r'''
  query GetMessagesBetweenUsers($senderId: uuid!, $receiverId: uuid!, $limit: Int!) {
    messages(where: {
      _and: [
        { _or: [
          { _and: [
            { sender_id: { _eq: $senderId } },
            { receiver_id: { _eq: $receiverId } }
          ] },
          { _and: [
            { sender_id: { _eq: $receiverId } },
            { receiver_id: { _eq: $senderId } }
          ] }
        ] }
      ]
    }, limit: $limit, order_by: {created_at: desc}) {
      id
      content
      sender_id
      receiver_id
      created_at
      updated_at
    }
  }
''';
