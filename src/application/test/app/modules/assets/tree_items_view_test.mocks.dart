// Mocks generated by Mockito 5.4.4 from annotations
// in application/test/app/modules/assets/widgets/tree_items_view_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:domain/domain.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeCompany_0 extends _i1.SmartFake implements _i2.Company {
  _FakeCompany_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeIRepository_1<T> extends _i1.SmartFake
    implements _i2.IRepository<T> {
  _FakeIRepository_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AssetsServiceBase].
///
/// See the documentation for Mockito's code generation for more information.
class MockAssetsServiceBase extends _i1.Mock implements _i2.AssetsServiceBase {
  MockAssetsServiceBase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Company get company => (super.noSuchMethod(
        Invocation.getter(#company),
        returnValue: _FakeCompany_0(
          this,
          Invocation.getter(#company),
        ),
      ) as _i2.Company);

  @override
  set company(_i2.Company? _company) => super.noSuchMethod(
        Invocation.setter(
          #company,
          _company,
        ),
        returnValueForMissingStub: null,
      );

  @override
  List<_i2.AssetFilter> get customFilters => (super.noSuchMethod(
        Invocation.getter(#customFilters),
        returnValue: <_i2.AssetFilter>[],
      ) as List<_i2.AssetFilter>);

  @override
  _i2.IRepository<_i2.Asset> get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeIRepository_1<_i2.Asset>(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.IRepository<_i2.Asset>);

  @override
  _i3.Future<List<_i2.Asset>> getAll() => (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [],
        ),
        returnValue: _i3.Future<List<_i2.Asset>>.value(<_i2.Asset>[]),
      ) as _i3.Future<List<_i2.Asset>>);
}

/// A class which mocks [LocationsServiceBase].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocationsServiceBase extends _i1.Mock
    implements _i2.LocationsServiceBase {
  MockLocationsServiceBase() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.Company get company => (super.noSuchMethod(
        Invocation.getter(#company),
        returnValue: _FakeCompany_0(
          this,
          Invocation.getter(#company),
        ),
      ) as _i2.Company);

  @override
  set company(_i2.Company? _company) => super.noSuchMethod(
        Invocation.setter(
          #company,
          _company,
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i2.IRepository<_i2.Location> get repository => (super.noSuchMethod(
        Invocation.getter(#repository),
        returnValue: _FakeIRepository_1<_i2.Location>(
          this,
          Invocation.getter(#repository),
        ),
      ) as _i2.IRepository<_i2.Location>);

  @override
  _i3.Future<List<_i2.Location>> getAll() => (super.noSuchMethod(
        Invocation.method(
          #getAll,
          [],
        ),
        returnValue: _i3.Future<List<_i2.Location>>.value(<_i2.Location>[]),
      ) as _i3.Future<List<_i2.Location>>);
}