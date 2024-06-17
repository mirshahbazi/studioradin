// chat_message.dart
class ChatMessage {
  final String id;
  final String userId;
  final String message;
  final DateTime timestamp;

  ChatMessage({required this.id, required this.userId, required this.message, required this.timestamp});

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      userId: json['userId'],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'message': message,
    'timestamp': timestamp.toIso8601String(),
  };
}