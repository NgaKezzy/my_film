// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ThemeStateCWProxy {
  ThemeState isDark(bool isDark);

  ThemeState status(ThemeStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ThemeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ThemeState(...).copyWith(id: 12, name: "My name")
  /// ````
  ThemeState call({
    bool? isDark,
    ThemeStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfThemeState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfThemeState.copyWith.fieldName(...)`
class _$ThemeStateCWProxyImpl implements _$ThemeStateCWProxy {
  const _$ThemeStateCWProxyImpl(this._value);

  final ThemeState _value;

  @override
  ThemeState isDark(bool isDark) => this(isDark: isDark);

  @override
  ThemeState status(ThemeStatus status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ThemeState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ThemeState(...).copyWith(id: 12, name: "My name")
  /// ````
  ThemeState call({
    Object? isDark = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return ThemeState(
      isDark: isDark == const $CopyWithPlaceholder() || isDark == null
          ? _value.isDark
          // ignore: cast_nullable_to_non_nullable
          : isDark as bool,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as ThemeStatus,
    );
  }
}

extension $ThemeStateCopyWith on ThemeState {
  /// Returns a callable class that can be used as follows: `instanceOfThemeState.copyWith(...)` or like so:`instanceOfThemeState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ThemeStateCWProxy get copyWith => _$ThemeStateCWProxyImpl(this);
}
