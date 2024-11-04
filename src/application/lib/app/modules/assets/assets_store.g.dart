// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AssetsStore on _AssetsStoreBase, Store {
  Computed<Company>? _$companyComputed;

  @override
  Company get company =>
      (_$companyComputed ??= Computed<Company>(() => super.company,
              name: '_AssetsStoreBase.company'))
          .value;

  late final _$assetsTreeAtom =
      Atom(name: '_AssetsStoreBase.assetsTree', context: context);

  @override
  AssetsTree get assetsTree {
    _$assetsTreeAtom.reportRead();
    return super.assetsTree;
  }

  bool _assetsTreeIsInitialized = false;

  @override
  set assetsTree(AssetsTree value) {
    _$assetsTreeAtom.reportWrite(
        value, _assetsTreeIsInitialized ? super.assetsTree : null, () {
      super.assetsTree = value;
      _assetsTreeIsInitialized = true;
    });
  }

  late final _$assetsAtom =
      Atom(name: '_AssetsStoreBase.assets', context: context);

  @override
  List<Asset> get assets {
    _$assetsAtom.reportRead();
    return super.assets;
  }

  @override
  set assets(List<Asset> value) {
    _$assetsAtom.reportWrite(value, super.assets, () {
      super.assets = value;
    });
  }

  late final _$locationsAtom =
      Atom(name: '_AssetsStoreBase.locations', context: context);

  @override
  List<Location> get locations {
    _$locationsAtom.reportRead();
    return super.locations;
  }

  @override
  set locations(List<Location> value) {
    _$locationsAtom.reportWrite(value, super.locations, () {
      super.locations = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_AssetsStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$selectedFiltersAtom =
      Atom(name: '_AssetsStoreBase.selectedFilters', context: context);

  @override
  List<AssetFilter> get selectedFilters {
    _$selectedFiltersAtom.reportRead();
    return super.selectedFilters;
  }

  @override
  set selectedFilters(List<AssetFilter> value) {
    _$selectedFiltersAtom.reportWrite(value, super.selectedFilters, () {
      super.selectedFilters = value;
    });
  }

  late final _$hasFiltersAtom =
      Atom(name: '_AssetsStoreBase.hasFilters', context: context);

  @override
  bool get hasFilters {
    _$hasFiltersAtom.reportRead();
    return super.hasFilters;
  }

  @override
  set hasFilters(bool value) {
    _$hasFiltersAtom.reportWrite(value, super.hasFilters, () {
      super.hasFilters = value;
    });
  }

  late final _$onLoadAsyncAction =
      AsyncAction('_AssetsStoreBase.onLoad', context: context);

  @override
  Future<void> onLoad() {
    return _$onLoadAsyncAction.run(() => super.onLoad());
  }

  late final _$refreshAsyncAction =
      AsyncAction('_AssetsStoreBase.refresh', context: context);

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  late final _$setIsLoadingAsyncAction =
      AsyncAction('_AssetsStoreBase.setIsLoading', context: context);

  @override
  Future<void> setIsLoading(bool isLoading) {
    return _$setIsLoadingAsyncAction.run(() => super.setIsLoading(isLoading));
  }

  late final _$selectFilterAsyncAction =
      AsyncAction('_AssetsStoreBase.selectFilter', context: context);

  @override
  Future<void> selectFilter(AssetFilter filter) {
    return _$selectFilterAsyncAction.run(() => super.selectFilter(filter));
  }

  @override
  String toString() {
    return '''
assetsTree: ${assetsTree},
assets: ${assets},
locations: ${locations},
isLoading: ${isLoading},
selectedFilters: ${selectedFilters},
hasFilters: ${hasFilters},
company: ${company}
    ''';
  }
}
