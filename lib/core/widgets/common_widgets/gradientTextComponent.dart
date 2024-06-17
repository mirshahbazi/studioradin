import 'package:flutter/material.dart';

Widget gradientTextComponent(Gradient gradient, String text,
    {double size = 48,
      FontWeight weight = FontWeight.w300,
      TextAlign align = TextAlign.center}) {
  const rect = Rect.fromLTWH(0.0, 0.0, 200.0, 70.0);
  final Shader linearGradient = gradient.createShader(rect);

  return Text(
    text,
    textAlign: align,
    style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        foreground: Paint()..shader = linearGradient),
  );
}