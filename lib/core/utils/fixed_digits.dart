import 'package:flutter/widgets.dart';

/// Extension adding a fixed-length digits [Text] transformer.
extension FixedDigitsExtension on Text {
  /// [RegExp] detecting numbers.
  static final RegExp _regex = RegExp(r'\d');

  /// Returns a [Text] guaranteed to have fixed width of digits in it.
  Widget fixedDigits() {
    Text copyWith(String string) {
      return Text(
        string,
        style: style,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        locale: locale,
        softWrap: softWrap,
        overflow: overflow,
        textScaler: textScaler,
        maxLines: maxLines,
        textWidthBasis: textWidthBasis,
        textHeightBehavior: textHeightBehavior,
        selectionColor: selectionColor,
      );
    }

    return Stack(
      children: [
        Opacity(opacity: 0, child: copyWith(data!.replaceAll(_regex, '0'))),
        copyWith(data!),
      ],
    );
  }
}
