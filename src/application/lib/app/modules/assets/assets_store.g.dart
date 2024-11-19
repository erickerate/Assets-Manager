// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AssetsStore on AssetsStoreBase, Store {
  Computed<bool>? _$hasFiltersComputed;

  @override
  bool get hasFilters =>
      (_$hasFiltersComputed ??= Computed<bool>(() => super.hasFilters,
              name: 'AssetsStoreBase.hasFilters'))
          .value;

  late final _$initializedAtom =
      Atom(name: 'AssetsStoreBase.initialized', context: context);

  @override
  bool get initialized {
    _$initializedAtom.reportRead();
    return super.initialized;
  }

  @override
  set initialized(bool value) {
    _$initializedAtom.reportWrite(value, super.initialized, () {
      super.initialized = value;
    });
  }

  late final _$assetsAtom =
      Atom(name: 'AssetsStoreBase.assets', context: context);

  @override
  List<Asset> get assets {
    _$assetsAtom.reportRead();
    return super.assets;
  }

  bool _assetsIsInitialized = false;

  @override
  set assets(List<Asset> value) {
    _$assetsAtom.reportWrite(value, _assetsIsInitialized ? super.assets : null,
        () {
      super.assets = value;
      _assetsIsInitialized = true;
    });
  }

  late final _$treeItemStoresAtom =
      Atom(name: 'AssetsStoreBase.treeItemStores', context: context);

  @override
  Map<String, ITreeItemStore> get treeItemStores {
    _$treeItemStoresAtom.reportRead();
    return super.treeItemStores;
  }

  bool _treeItemStoresIsInitialized = false;

  @override
  set treeItemStores(Map<String, ITreeItemStore> value) {
    _$treeItemStoresAtom.reportWrite(
        value, _treeItemStoresIsInitialized ? super.treeItemStores : null, () {
      super.treeItemStores = value;
      _treeItemStoresIsInitialized = true;
    });
  }

  late final _$locationsAtom =
      Atom(name: 'AssetsStoreBase.locations', context: context);

  @override
  List<Location> get locations {
    _$locationsAtom.reportRead();
    return super.locations;
  }

  bool _locationsIsInitialized = false;

  @override
  set locations(List<Location> value) {
    _$locationsAtom.reportWrite(
        value, _locationsIsInitialized ? super.locations : null, () {
      super.locations = value;
      _locationsIsInitialized = true;
    });
  }

  late final _$selectedCustomFiltersAtom =
      Atom(name: 'AssetsStoreBase.selectedCustomFilters', context: context);

  @override
  List<AssetFilter> get selectedCustomFilters {
    _$selectedCustomFiltersAtom.reportRead();
    return super.selectedCustomFilters;
  }

  @override
  set selectedCustomFilters(List<AssetFilter> value) {
    _$selectedCustomFiltersAtom.reportWrite(value, super.selectedCustomFilters,
        () {
      super.selectedCustomFilters = value;
    });
  }

  late final _$textSearchFilterAtom =
      Atom(name: 'AssetsStoreBase.textSearchFilter', context: context);

  @override
  TextSearchFilter get textSearchFilter {
    _$textSearchFilterAtom.reportRead();
    return super.textSearchFilter;
  }

  @override
  set textSearchFilter(TextSearchFilter value) {
    _$textSearchFilterAtom.reportWrite(value, super.textSearchFilter, () {
      super.textSearchFilter = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'AssetsStoreBase.isLoading', context: context);

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

  late final _$buildTreeAssetsAsyncAction =
      AsyncAction('AssetsStoreBase.buildTreeAssets', context: context);

  @override
  Future<void> buildTreeAssets() {
    return _$buildTreeAssetsAsyncAction.run(() => super.buildTreeAssets());
  }

  late final _$refreshAssetsTreeAsyncAction =
      AsyncAction('AssetsStoreBase.refreshAssetsTree', context: context);

  @override
  Future<void> refreshAssetsTree() {
    return _$refreshAssetsTreeAsyncAction.run(() => super.refreshAssetsTree());
  }

  late final _$selectCustomFilterAsyncAction =
      AsyncAction('AssetsStoreBase.selectCustomFilter', context: context);

  @override
  Future<void> selectCustomFilter(AssetFilter filter) {
    return _$selectCustomFilterAsyncAction
        .run(() => super.selectCustomFilter(filter));
  }

  late final _$onTextSearchFilterChangedAsyncAction = AsyncAction(
      'AssetsStoreBase.onTextSearchFilterChanged',
      context: context);

  @override
  Future<void> onTextSearchFilterChanged(String value) {
    return _$onTextSearchFilterChangedAsyncAction
        .run(() => super.onTextSearchFilterChanged(value));
  }

  late final _$dispatchIsLoadingAsyncAction =
      AsyncAction('AssetsStoreBase.dispatchIsLoading', context: context);

  @override
  Future<void> dispatchIsLoading(bool isLoading) {
    return _$dispatchIsLoadingAsyncAction
        .run(() => super.dispatchIsLoading(isLoading));
  }

  late final _$AssetsStoreBaseActionController =
      ActionController(name: 'AssetsStoreBase', context: context);

  @override
  void setInitialized(bool initialized) {
    final _$actionInfo = _$AssetsStoreBaseActionController.startAction(
        name: 'AssetsStoreBase.setInitialized');
    try {
      return super.setInitialized(initialized);
    } finally {
      _$AssetsStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
initialized: ${initialized},
assets: ${assets},
treeItemStores: ${treeItemStores},
locations: ${locations},
selectedCustomFilters: ${selectedCustomFilters},
textSearchFilter: ${textSearchFilter},
isLoading: ${isLoading},
hasFilters: ${hasFilters}
    ''';
  }
}
