import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';

class AppInfoModel extends ChangeNotifier {
  late String _version;
  String get version => _version;

  late String _appName;
  String get appName => _appName;

  AppInfoModel(PackageInfo pi) {
    _version = pi.version;
    _appName = pi.appName;
  }
}
