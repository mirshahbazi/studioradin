
import 'user.dart';

class ContactModel {
  final List<UserModel>? users;

  ContactModel({this.users});

  factory ContactModel.fromJson(List<dynamic> json) {
    var users = json.map((userItem) => UserModel.fromJson(userItem)).toList();
    return ContactModel(users: users);
  }
}