import 'package:get/get.dart';

import '../../presentation/chat/chat_binding.dart';
import '../../presentation/chat/chat_view.dart';
import '../../presentation/splash/splash_binding.dart';
import '../../presentation/splash/splash_view.dart';

class Routes {
  static const root = '/';
  static const splash = '/splash';

  static const chat = '/chat';
}

class AppPages {
  static String getInitPage() {
    return Routes.splash;
  }

  static final routes = [
    GetPage(
        name: Routes.root,
        page: () => const SplashPage(),
        binding: SplashBinding()),
    GetPage(
      name: Routes.chat,
      page: () => const ChatPage(),
      binding: ChatBinding(),
    ),
  ];
}
