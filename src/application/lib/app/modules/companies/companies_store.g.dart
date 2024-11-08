// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'companies_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CompaniesStore on CompaniesStoreBase, Store {
  late final _$companiesAtom =
      Atom(name: 'CompaniesStoreBase.companies', context: context);

  @override
  List<Company> get companies {
    _$companiesAtom.reportRead();
    return super.companies;
  }

  @override
  set companies(List<Company> value) {
    _$companiesAtom.reportWrite(value, super.companies, () {
      super.companies = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'CompaniesStoreBase.isLoading', context: context);

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

  late final _$dispatchCompaniesAsyncAction =
      AsyncAction('CompaniesStoreBase.dispatchCompanies', context: context);

  @override
  Future<void> dispatchCompanies() {
    return _$dispatchCompaniesAsyncAction.run(() => super.dispatchCompanies());
  }

  late final _$dispatchIsLoadingAsyncAction =
      AsyncAction('CompaniesStoreBase.dispatchIsLoading', context: context);

  @override
  Future<void> dispatchIsLoading(bool isLoading) {
    return _$dispatchIsLoadingAsyncAction
        .run(() => super.dispatchIsLoading(isLoading));
  }

  @override
  String toString() {
    return '''
companies: ${companies},
isLoading: ${isLoading}
    ''';
  }
}
