import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final flavorProvider = ChangeNotifierProvider<FlavorNotifier>((ref) {
  const flavor = String.fromEnvironment('FLAVOR');
  return FlavorNotifier(flavor);
});

class FlavorNotifier extends ChangeNotifier {
  FlavorNotifier(this._flavor);

  final String _flavor;

  bool isProduction() {
    return _flavor == 'prd';
  }

  String getFlavor() {
    return _flavor;
  }

  bool showDebugBanner() {
    return isProduction() ? false : true;
  }
}
