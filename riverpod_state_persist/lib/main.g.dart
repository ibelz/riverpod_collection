// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sharedPrefHash() => r'bdee7f18bca471ecebdea207c3d7852a2fa275c6';

/// See also [sharedPref].
@ProviderFor(sharedPref)
final sharedPrefProvider = FutureProvider<SharedPreferences>.internal(
  sharedPref,
  name: r'sharedPrefProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$sharedPrefHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SharedPrefRef = FutureProviderRef<SharedPreferences>;
String _$counterHash() => r'efb777aefebc58695e6ef67cbf83034b0e0e8ee8';

/// See also [Counter].
@ProviderFor(Counter)
final counterProvider = AutoDisposeAsyncNotifierProvider<Counter, int>.internal(
  Counter.new,
  name: r'counterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$counterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Counter = AutoDisposeAsyncNotifier<int>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
