class ChatsModel {
  final String id;
  final String imageUrl;
  final String fullName;
  final String message;
  final DateTime dateTime;

  ChatsModel({
    required this.id,
    required this.imageUrl,
    required this.fullName,
    required this.message,
    required this.dateTime,
  });

  // Convert a Message object to a Map object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'fullName': fullName,
      'message': message,
      'dateTime': dateTime.toIso8601String(),
    };
  }

  // Convert a Map object to a Message object
  factory ChatsModel.fromJson(Map<String, dynamic> json) {
    return ChatsModel(
      id: json['id'],
      imageUrl: json['imageUrl'],
      fullName: json['fullName'],
      message: json['message'],
      dateTime: DateTime.parse(json['dateTime']),
    );
  }
}
