
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



/// Custom styled [SpinKitDoubleBounce].
class DoubleBounceLoadingIndicator extends StatelessWidget {
  const DoubleBounceLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context).primaryColor;

    return SpinKitDoubleBounce(
      color: style,
      size: 100 / 1.5,
      duration: const Duration(milliseconds: 4500),
    );
  }
}
