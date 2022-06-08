// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'app_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AppSetting {
  bool get isDeleteConfirm => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AppSettingCopyWith<AppSetting> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AppSettingCopyWith<$Res> {
  factory $AppSettingCopyWith(
          AppSetting value, $Res Function(AppSetting) then) =
      _$AppSettingCopyWithImpl<$Res>;
  $Res call({bool isDeleteConfirm});
}

/// @nodoc
class _$AppSettingCopyWithImpl<$Res> implements $AppSettingCopyWith<$Res> {
  _$AppSettingCopyWithImpl(this._value, this._then);

  final AppSetting _value;
  // ignore: unused_field
  final $Res Function(AppSetting) _then;

  @override
  $Res call({
    Object? isDeleteConfirm = freezed,
  }) {
    return _then(_value.copyWith(
      isDeleteConfirm: isDeleteConfirm == freezed
          ? _value.isDeleteConfirm
          : isDeleteConfirm // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_AppSettingCopyWith<$Res>
    implements $AppSettingCopyWith<$Res> {
  factory _$$_AppSettingCopyWith(
          _$_AppSetting value, $Res Function(_$_AppSetting) then) =
      __$$_AppSettingCopyWithImpl<$Res>;
  @override
  $Res call({bool isDeleteConfirm});
}

/// @nodoc
class __$$_AppSettingCopyWithImpl<$Res> extends _$AppSettingCopyWithImpl<$Res>
    implements _$$_AppSettingCopyWith<$Res> {
  __$$_AppSettingCopyWithImpl(
      _$_AppSetting _value, $Res Function(_$_AppSetting) _then)
      : super(_value, (v) => _then(v as _$_AppSetting));

  @override
  _$_AppSetting get _value => super._value as _$_AppSetting;

  @override
  $Res call({
    Object? isDeleteConfirm = freezed,
  }) {
    return _then(_$_AppSetting(
      isDeleteConfirm: isDeleteConfirm == freezed
          ? _value.isDeleteConfirm
          : isDeleteConfirm // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_AppSetting with DiagnosticableTreeMixin implements _AppSetting {
  const _$_AppSetting({this.isDeleteConfirm = false});

  @override
  @JsonKey()
  final bool isDeleteConfirm;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AppSetting(isDeleteConfirm: $isDeleteConfirm)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AppSetting'))
      ..add(DiagnosticsProperty('isDeleteConfirm', isDeleteConfirm));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AppSetting &&
            const DeepCollectionEquality()
                .equals(other.isDeleteConfirm, isDeleteConfirm));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(isDeleteConfirm));

  @JsonKey(ignore: true)
  @override
  _$$_AppSettingCopyWith<_$_AppSetting> get copyWith =>
      __$$_AppSettingCopyWithImpl<_$_AppSetting>(this, _$identity);
}

abstract class _AppSetting implements AppSetting {
  const factory _AppSetting({final bool isDeleteConfirm}) = _$_AppSetting;

  @override
  bool get isDeleteConfirm => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_AppSettingCopyWith<_$_AppSetting> get copyWith =>
      throw _privateConstructorUsedError;
}
