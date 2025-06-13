// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_products_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchProductsFromCategoriesHash() =>
    r'45fb64d8fd427a3be1239474410deb5a30733a46';

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

/// See also [fetchProductsFromCategories].
@ProviderFor(fetchProductsFromCategories)
const fetchProductsFromCategoriesProvider = FetchProductsFromCategoriesFamily();

/// See also [fetchProductsFromCategories].
class FetchProductsFromCategoriesFamily
    extends Family<AsyncValue<List<ProductModel>>> {
  /// See also [fetchProductsFromCategories].
  const FetchProductsFromCategoriesFamily();

  /// See also [fetchProductsFromCategories].
  FetchProductsFromCategoriesProvider call(int id) {
    return FetchProductsFromCategoriesProvider(id);
  }

  @override
  FetchProductsFromCategoriesProvider getProviderOverride(
    covariant FetchProductsFromCategoriesProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchProductsFromCategoriesProvider';
}

/// See also [fetchProductsFromCategories].
class FetchProductsFromCategoriesProvider
    extends AutoDisposeFutureProvider<List<ProductModel>> {
  /// See also [fetchProductsFromCategories].
  FetchProductsFromCategoriesProvider(int id)
    : this._internal(
        (ref) => fetchProductsFromCategories(
          ref as FetchProductsFromCategoriesRef,
          id,
        ),
        from: fetchProductsFromCategoriesProvider,
        name: r'fetchProductsFromCategoriesProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$fetchProductsFromCategoriesHash,
        dependencies: FetchProductsFromCategoriesFamily._dependencies,
        allTransitiveDependencies:
            FetchProductsFromCategoriesFamily._allTransitiveDependencies,
        id: id,
      );

  FetchProductsFromCategoriesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<List<ProductModel>> Function(
      FetchProductsFromCategoriesRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchProductsFromCategoriesProvider._internal(
        (ref) => create(ref as FetchProductsFromCategoriesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ProductModel>> createElement() {
    return _FetchProductsFromCategoriesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchProductsFromCategoriesProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin FetchProductsFromCategoriesRef
    on AutoDisposeFutureProviderRef<List<ProductModel>> {
  /// The parameter `id` of this provider.
  int get id;
}

class _FetchProductsFromCategoriesProviderElement
    extends AutoDisposeFutureProviderElement<List<ProductModel>>
    with FetchProductsFromCategoriesRef {
  _FetchProductsFromCategoriesProviderElement(super.provider);

  @override
  int get id => (origin as FetchProductsFromCategoriesProvider).id;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
