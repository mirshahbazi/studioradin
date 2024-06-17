import 'package:studioradin/data/models/user.dart';

import '../../domain/entities/message.dart';


class MessageModel {
  final UserModel? user;
  final String? id;
  final String? content;
  final String? senderId;
  final String? receiverId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  MessageModel({
    required this.user,
    required this.id,
    required this.content,
    required this.senderId,
    required this.receiverId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      id: json['id'] as String?,
      content: json['content'] as String?,
      senderId: json['sender_id'] as String?,
      receiverId: json['receiver_id'] as String?,
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      updatedAt: json['updated_at'] != null ? DateTime.parse(json['updated_at']) : null,
      user: UserModel(id: json['id'],email: '',profilePicture: '',fullName: '',updatedAt: DateTime.parse(json['created_at'])  ,createdAt: DateTime.parse(json['created_at'])  ),
    );
  }

  Map<String, dynamic> toJson() => {
    "user": user?.toJson() ?? '',
    "content": content,
    "id": id,
    "receiver_id": receiverId,
    "senderId": senderId,
    "create_at": createdAt.toString(),
    "updated_at": updatedAt.toString(),
  };

  static List<MessageModel>? fromJsonList(List jsonList) {
    if (jsonList == null)
      return null;
    else {
      return jsonList
          .map((item) => MessageModel.fromJson(item))
          .toList();
    }
  }

  Message toEntity() {
    return Message(
      id: id,
      user: user,
      content: content,
      senderId: senderId,
      receiverId: receiverId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
