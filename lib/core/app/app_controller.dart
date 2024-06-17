import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../data/models/chats_model.dart';
import '../../data/models/message.dart';
import '../../data/models/user.dart';
import '../services/storage_services.dart';
import '../utils/constants.dart';
import 'app_repository.dart';

class AppController extends GetxController {
  final _userBox = GetStorage('userBox');
  final _darkModeBox = GetStorage('darkModeBox');

  // Rx<UserModel?> to hold the user data
  final Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  // RxBool for dark mode
  final RxBool darkMode = false.obs;
  StreamSubscription<List<MessageModel>?>? messagesSubscription;

  final StorageService storageService = StorageService();
  // final AppRepository appRepository = Get.find<AppRepository>(); // Inject AppRepository
  final AppRepository appRepository;

  AppController( this.appRepository);
  @override
  void onInit() {
    super.onInit();
    // Initialize default values if not present
    _userBox.writeIfNull(
      'currentUserLogedIn',
      UserModel(
        id: userId,
        fullName: 'محمد علی میرشهبازی',
        profilePicture: '',
        email: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ).toJsonString(),
    );
    _darkModeBox.writeIfNull('darkMode', false);

    // Load initial data
    final userJson = _userBox.read('currentUserLogedIn');
    if (userJson != null) {
      currentUser.value = UserModel.fromJsonString(userJson);
    }

    darkMode.value = _darkModeBox.read('darkMode');

    // Watch changes and persist them
    ever(currentUser, (_) {
      _userBox.write('currentUserLogedIn', currentUser.value?.toJson());
    });

    ever(darkMode, (value) {
      _darkModeBox.write('darkMode', value);
    });

    // Initialize messages subscription
    initializeMessagesSubscription();
  }

  void toggleDarkMode() {
    darkMode.value = !darkMode.value;
  }

  void addMessage(ChatsModel message) {
    storageService.updateMessage(message);
  }

  void initializeMessagesSubscription() {
    appRepository.subscribeToNewMessages(currentUser.value!.id); // Pass current user ID to subscribe to new messages
  }
}
