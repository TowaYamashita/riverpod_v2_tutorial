// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_with_type_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$activityWithTypeHash() => r'e821884c6335085cc48994e28070748ee6b89c7a';

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

/// See also [activityWithType].
@ProviderFor(activityWithType)
const activityWithTypeProvider = ActivityWithTypeFamily();

/// See also [activityWithType].
class ActivityWithTypeFamily extends Family<AsyncValue<Activity>> {
  /// See also [activityWithType].
  const ActivityWithTypeFamily();

  /// See also [activityWithType].
  ActivityWithTypeProvider call(
    String activityType,
  ) {
    return ActivityWithTypeProvider(
      activityType,
    );
  }

  @override
  ActivityWithTypeProvider getProviderOverride(
    covariant ActivityWithTypeProvider provider,
  ) {
    return call(
      provider.activityType,
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
  String? get name => r'activityWithTypeProvider';
}

/// See also [activityWithType].
class ActivityWithTypeProvider extends AutoDisposeFutureProvider<Activity> {
  /// See also [activityWithType].
  ActivityWithTypeProvider(
    String activityType,
  ) : this._internal(
          (ref) => activityWithType(
            ref as ActivityWithTypeRef,
            activityType,
          ),
          from: activityWithTypeProvider,
          name: r'activityWithTypeProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$activityWithTypeHash,
          dependencies: ActivityWithTypeFamily._dependencies,
          allTransitiveDependencies:
              ActivityWithTypeFamily._allTransitiveDependencies,
          activityType: activityType,
        );

  ActivityWithTypeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.activityType,
  }) : super.internal();

  final String activityType;

  @override
  Override overrideWith(
    FutureOr<Activity> Function(ActivityWithTypeRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ActivityWithTypeProvider._internal(
        (ref) => create(ref as ActivityWithTypeRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        activityType: activityType,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Activity> createElement() {
    return _ActivityWithTypeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ActivityWithTypeProvider &&
        other.activityType == activityType;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, activityType.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ActivityWithTypeRef on AutoDisposeFutureProviderRef<Activity> {
  /// The parameter `activityType` of this provider.
  String get activityType;
}

class _ActivityWithTypeProviderElement
    extends AutoDisposeFutureProviderElement<Activity>
    with ActivityWithTypeRef {
  _ActivityWithTypeProviderElement(super.provider);

  @override
  String get activityType => (origin as ActivityWithTypeProvider).activityType;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
