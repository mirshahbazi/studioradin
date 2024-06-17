

import '../../data/models/user.dart';

class Message {
  final String? id;
  final String? content;
  final String? senderId;
  final String? receiverId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final UserModel? user;

  Message({
    required this.id,
    required this.user,
    required this.content,
    required this.senderId,
    required this.receiverId,
    required this.createdAt,
    required this.updatedAt,
  });
}
