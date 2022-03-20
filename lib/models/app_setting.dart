import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'app_setting.freezed.dart';

@freezed
class AppSetting with _$AppSetting {
  const factory AppSetting({
    @Default(false) bool isDeleteConfirm,
  }) = _AppSetting;
}
