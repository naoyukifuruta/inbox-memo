import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class AppModel extends ChangeNotifier {
  late String _version;
  String get version => _version;

  late String _appName;
  String get appName => _appName;

  AppModel(PackageInfo pi) {
    _version = pi.version;
    _appName = pi.appName;
  }
}
