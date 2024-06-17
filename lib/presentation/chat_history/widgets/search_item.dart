

import '../../../data/models/contact_model.dart';
import '../../../data/models/user.dart';
import '../chat_history_logic.dart';

List<UserModel>? searchItem(ChatHistoryLogic controller, ContactModel list) {
  final usersList = list.users;
  if (controller.searchText.value.isEmpty) return usersList;

  final filteredList = usersList?.where(
        (user) => user.fullName.toLowerCase().contains(controller.searchText.value.toLowerCase()),
  );
  return filteredList?.toList();
}
