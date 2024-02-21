// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_setting.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
      _$AppSettingCopyWithImpl<$Res, AppSetting>;
  @useResult
  $Res call({bool isDeleteConfirm});
}

/// @nodoc
class _$AppSettingCopyWithImpl<$Res, $Val extends AppSetting>
    implements $AppSettingCopyWith<$Res> {
  _$AppSettingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDeleteConfirm = null,
  }) {
    return _then(_value.copyWith(
      isDeleteConfirm: null == isDeleteConfirm
          ? _value.isDeleteConfirm
          : isDeleteConfirm // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AppSettingImplCopyWith<$Res>
    implements $AppSettingCopyWith<$Res> {
  factory _$$AppSettingImplCopyWith(
          _$AppSettingImpl value, $Res Function(_$AppSettingImpl) then) =
      __$$AppSettingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isDeleteConfirm});
}

/// @nodoc
class __$$AppSettingImplCopyWithImpl<$Res>
    extends _$AppSettingCopyWithImpl<$Res, _$AppSettingImpl>
    implements _$$AppSettingImplCopyWith<$Res> {
  __$$AppSettingImplCopyWithImpl(
      _$AppSettingImpl _value, $Res Function(_$AppSettingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isDeleteConfirm = null,
  }) {
    return _then(_$AppSettingImpl(
      isDeleteConfirm: null == isDeleteConfirm
          ? _value.isDeleteConfirm
          : isDeleteConfirm // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$AppSettingImpl with DiagnosticableTreeMixin implements _AppSetting {
  const _$AppSettingImpl({this.isDeleteConfirm = false});

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AppSettingImpl &&
            (identical(other.isDeleteConfirm, isDeleteConfirm) ||
                other.isDeleteConfirm == isDeleteConfirm));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isDeleteConfirm);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AppSettingImplCopyWith<_$AppSettingImpl> get copyWith =>
      __$$AppSettingImplCopyWithImpl<_$AppSettingImpl>(this, _$identity);
}

abstract class _AppSetting implements AppSetting {
  const factory _AppSetting({final bool isDeleteConfirm}) = _$AppSettingImpl;

  @override
  bool get isDeleteConfirm;
  @override
  @JsonKey(ignore: true)
  _$$AppSettingImplCopyWith<_$AppSettingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
