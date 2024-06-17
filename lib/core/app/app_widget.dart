import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/public_const.dart';
import '../constants/theme/styles.dart';
import '../routes/routes.dart';
import '../widgets/common_widgets/root_widget.dart';
import 'app_bindings.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: GetMaterialApp(
        // get the current language text direction
        textDirection: TextDirection.rtl,
        supportedLocales: const [Locale('fa'), Locale('en')],
        enableLog: false,
        debugShowCheckedModeBanner: false,
        color: Styles.primaryColor,
        theme: Styles.light,
        darkTheme: Styles.dark,
        title: appName,
        initialBinding: AppBindings(),
        getPages: AppPages.routes,
        builder: MyRootWidget.builder,
        initialRoute: AppPages.getInitPage(),
        defaultTransition: Transition.fadeIn,
      ),
    );
  }
}
