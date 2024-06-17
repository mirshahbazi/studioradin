import 'package:get/get.dart';

import '../../data/models/contact_model.dart';
import '../../domain/usecases/get_users.dart';
import 'contact_state.dart';

class ContactLogic extends GetxController {
  final ContactState state = ContactState();

  final GetUsers userUseCase;

  Rx<ContactModel?> users = Rx<ContactModel?>(null);
  var isLoading = false.obs;
  var isSearching = false.obs;
  var searchText = ''.obs;

  ContactLogic({required this.userUseCase});

  void fetchUsers() async {
    isLoading.value = true;
    try {
      users.value = (await userUseCase.call());
    } finally {
      isLoading.value = false;
    }
  }

  List<String> selectionList = [];
  String groupName = "";

  void updateGroupName(String val) {
    groupName = val;
    update();
  }

  void updateSearchText(String text) {
    searchText.value = text;
  }

  void updateSearchVisibility(bool state) {
    isSearching.value = state;
  }

  void toggleSelection(String id) {
    if (selectionList.contains(id)) {
      selectionList.remove(id);
    } else {
      selectionList.add(id);
    }
    update();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
