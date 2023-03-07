// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'main.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchItemsHash() => r'00d51c6d40cdc87a98592acc8f320f127f67a76d';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef FetchItemsRef = FutureProviderRef<List<String>>;

/// See also [fetchItems].
@ProviderFor(fetchItems)
const fetchItemsProvider = FetchItemsFamily();

/// See also [fetchItems].
class FetchItemsFamily extends Family<AsyncValue<List<String>>> {
  /// See also [fetchItems].
  const FetchItemsFamily();

  /// See also [fetchItems].
  FetchItemsProvider call(
    int page,
  ) {
    return FetchItemsProvider(
      page,
    );
  }

  @override
  FetchItemsProvider getProviderOverride(
    covariant FetchItemsProvider provider,
  ) {
    return call(
      provider.page,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchItemsProvider';
}

/// See also [fetchItems].
class FetchItemsProvider extends FutureProvider<List<String>> {
  /// See also [fetchItems].
  FetchItemsProvider(
    this.page,
  ) : super.internal(
          (ref) => fetchItems(
            ref,
            page,
          ),
          from: fetchItemsProvider,
          name: r'fetchItemsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchItemsHash,
          dependencies: FetchItemsFamily._dependencies,
          allTransitiveDependencies:
              FetchItemsFamily._allTransitiveDependencies,
        );

  final int page;

  @override
  bool operator ==(Object other) {
    return other is FetchItemsProvider && other.page == page;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions
