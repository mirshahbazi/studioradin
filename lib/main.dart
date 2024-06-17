import 'package:flutter/material.dart';

import 'core/app/app_widget.dart';
import 'core/services/notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalNotification.init();
  runApp(MyApp());
}

