// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'my_app_theme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MyAppTheme {
  bool get isDark => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MyAppThemeCopyWith<MyAppTheme> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MyAppThemeCopyWith<$Res> {
  factory $MyAppThemeCopyWith(
          MyAppTheme value, $Res Function(MyAppTheme) then) =
      _$MyAppThemeCopyWithImpl<$Res>;
  $Res call({bool isDark});
}

/// @nodoc
class _$MyAppThemeCopyWithImpl<$Res> implements $MyAppThemeCopyWith<$Res> {
  _$MyAppThemeCopyWithImpl(this._value, this._then);

  final MyAppTheme _value;
  // ignore: unused_field
  final $Res Function(MyAppTheme) _then;

  @override
  $Res call({
    Object? isDark = freezed,
  }) {
    return _then(_value.copyWith(
      isDark: isDark == freezed
          ? _value.isDark
          : isDark // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_MyAppThemeCopyWith<$Res>
    implements $MyAppThemeCopyWith<$Res> {
  factory _$$_MyAppThemeCopyWith(
          _$_MyAppTheme value, $Res Function(_$_MyAppTheme) then) =
      __$$_MyAppThemeCopyWithImpl<$Res>;
  @override
  $Res call({bool isDark});
}

/// @nodoc
class __$$_MyAppThemeCopyWithImpl<$Res> extends _$MyAppThemeCopyWithImpl<$Res>
    implements _$$_MyAppThemeCopyWith<$Res> {
  __$$_MyAppThemeCopyWithImpl(
      _$_MyAppTheme _value, $Res Function(_$_MyAppTheme) _then)
      : super(_value, (v) => _then(v as _$_MyAppTheme));

  @override
  _$_MyAppTheme get _value => super._value as _$_MyAppTheme;

  @override
  $Res call({
    Object? isDark = freezed,
  }) {
    return _then(_$_MyAppTheme(
      isDark: isDark == freezed
          ? _value.isDark
          : isDark // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_MyAppTheme extends _MyAppTheme with DiagnosticableTreeMixin {
  const _$_MyAppTheme({this.isDark = false}) : super._();

  @override
  @JsonKey()
  final bool isDark;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'MyAppTheme(isDark: $isDark)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'MyAppTheme'))
      ..add(DiagnosticsProperty('isDark', isDark));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MyAppTheme &&
            const DeepCollectionEquality().equals(other.isDark, isDark));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(isDark));

  @JsonKey(ignore: true)
  @override
  _$$_MyAppThemeCopyWith<_$_MyAppTheme> get copyWith =>
      __$$_MyAppThemeCopyWithImpl<_$_MyAppTheme>(this, _$identity);
}

abstract class _MyAppTheme extends MyAppTheme {
  const factory _MyAppTheme({final bool isDark}) = _$_MyAppTheme;
  const _MyAppTheme._() : super._();

  @override
  bool get isDark => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_MyAppThemeCopyWith<_$_MyAppTheme> get copyWith =>
      throw _privateConstructorUsedError;
}
