import 'package:get/get.dart';
import 'package:hasura_connect/hasura_connect.dart' as Hasura;

import '../../data/repositories/user_repository.dart';
import '../../domain/usecases/get_users.dart';
import '../../presentation/call/call_logic.dart';
import '../../presentation/chat_history/chat_history_logic.dart';
import '../../presentation/contact/contact_logic.dart';
import '../../presentation/home/home_logic.dart';
import '../../presentation/setting/setting_logic.dart';
import '../services/hasura_service.dart';
import 'app_controller.dart';
import 'app_repository.dart';

// Define the bindings for GetX
class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<Hasura.HasuraConnect>(createHasuraConnect());
    final appRepository = Get.put<AppRepository>(AppRepository(Get.find<Hasura.HasuraConnect>()));
    Get.put<AppController>(AppController(appRepository));
    ///main logic
    Get.lazyPut(() => HomeLogic());
    Get.lazyPut(() => CallLogic());
    Get.lazyPut(() => SettingLogic());

    // Initialize Users logics
    final userRepository = UserRepository(Get.find<Hasura.HasuraConnect>());
    final getUsersUseCase = GetUsers(userRepository);
    Get.lazyPut(() => ContactLogic(userUseCase: getUsersUseCase));

    // Initialize Chat history logic
    Get.lazyPut(() => ChatHistoryLogic(userUseCase: getUsersUseCase));
  }
}
