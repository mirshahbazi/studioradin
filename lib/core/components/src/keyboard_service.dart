import 'package:flutter/material.dart';

class KeyboardService {
  static final KeyboardService _instance = KeyboardService.init();
  static KeyboardService get instance => _instance;
  KeyboardService.init();

  keyboardchek(context) => MediaQuery.of(context).viewInsets.bottom != 0;
}

// if (!KeyboardService.instance.keyboardchek(context))
// SizedBox(height: context.h * 0.05),