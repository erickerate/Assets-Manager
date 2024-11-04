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

  late final _$queryAssetsAsyncAction =
      AsyncAction('_AssetsStoreBase.queryAssets', context: context);

  @override
  Future<void> queryAssets() {
    return _$queryAssetsAsyncAction.run(() => super.queryAssets());
  }

  late final _$setIsLoadingAsyncAction =
      AsyncAction('_AssetsStoreBase.setIsLoading', context: context);

  @override
  Future<void> setIsLoading(bool isLoading) {
    return _$setIsLoadingAsyncAction.run(() => super.setIsLoading(isLoading));
  }

  @override
  String toString() {
    return '''
assets: ${assets},
locations: ${locations},
isLoading: ${isLoading},
company: ${company}
    ''';
  }
}
