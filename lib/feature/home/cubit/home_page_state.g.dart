// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_page_state.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$HomePageStateCWProxy {
  HomePageState isConnectNetwork(bool isConnectNetwork);

  HomePageState status(HomePageStatus status);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HomePageState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HomePageState(...).copyWith(id: 12, name: "My name")
  /// ````
  HomePageState call({
    bool? isConnectNetwork,
    HomePageStatus? status,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfHomePageState.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfHomePageState.copyWith.fieldName(...)`
class _$HomePageStateCWProxyImpl implements _$HomePageStateCWProxy {
  const _$HomePageStateCWProxyImpl(this._value);

  final HomePageState _value;

  @override
  HomePageState isConnectNetwork(bool isConnectNetwork) =>
      this(isConnectNetwork: isConnectNetwork);

  @override
  HomePageState status(HomePageStatus status) => this(status: status);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `HomePageState(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// HomePageState(...).copyWith(id: 12, name: "My name")
  /// ````
  HomePageState call({
    Object? isConnectNetwork = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
  }) {
    return HomePageState(
      isConnectNetwork: isConnectNetwork == const $CopyWithPlaceholder() ||
              isConnectNetwork == null
          ? _value.isConnectNetwork
          // ignore: cast_nullable_to_non_nullable
          : isConnectNetwork as bool,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as HomePageStatus,
    );
  }
}

extension $HomePageStateCopyWith on HomePageState {
  /// Returns a callable class that can be used as follows: `instanceOfHomePageState.copyWith(...)` or like so:`instanceOfHomePageState.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$HomePageStateCWProxy get copyWith => _$HomePageStateCWProxyImpl(this);
}
