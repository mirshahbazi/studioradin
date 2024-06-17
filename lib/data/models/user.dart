
import 'dart:convert';

import '../../domain/entities/user.dart';

class UserModel {
  final String id;
  final String email;
  final String fullName;
  final String profilePicture;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.profilePicture,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      fullName: json['full_name'],
      profilePicture: json['profile_picture'] ?? '',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }


  // Serialization to JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'profile_picture': profilePicture,
      'email': email,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
  // Deserialization from JSON string
  factory UserModel.fromJsonString(String jsonString) {
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return UserModel.fromJson(jsonMap);
  }

  // Serialization to JSON string
  String toJsonString() {
    return jsonEncode(toJson());
  }


  static List<UserModel>? fromJsonList(List jsonList) {
    if (jsonList == null) {
      return null;
    } else {
      return jsonList.map((item) => UserModel.fromJson(item)).toList();
    }
  }

  User toEntity() {
    return User(
      id: id,
      email: email,
      fullName: fullName,
      profilePicture: profilePicture,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
