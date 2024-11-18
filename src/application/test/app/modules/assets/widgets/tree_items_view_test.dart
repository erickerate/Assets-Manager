import 'dart:convert';
import 'dart:io';

import 'package:application/app/modules/assets/assets_module.dart';
import 'package:domain/domain.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:service/service.dart';

import 'tree_items_view_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AssetsService>()])
@GenerateNiceMocks([MockSpec<LocationsService>()])
void main() {
  final mockAssetsService = MockAssetsService();
  final mockLocationsService = MockLocationsService();
  late List<Asset> assets;
  late List<Location> locations;

  setUp(() async {
    File file = File('assets/mocks/assets.json');
    String jsonString = await file.readAsString();
    List<dynamic> items = json.decode(jsonString);
    assets = items.map((json) => Asset.fromJson(json)).toList();

    file = File('assets/mocks/locations.json');
    jsonString = await file.readAsString();
    items = json.decode(jsonString);
    locations = items.map((json) => Location.fromJson(json)).toList();
  });

  group('TreeItemsView :: ', () {
    testWidgets("", (WidgetTester tester) async {
      // #region Arrange

      when(mockAssetsService.getAll()).thenAnswer((_) async => assets);
      when(mockLocationsService.getAll()).thenAnswer((_) async => locations);

      Modular.replaceInstance<AssetsServiceBase>(mockAssetsService);
      Modular.replaceInstance<ServiceBase<Location>>(mockLocationsService);
      Modular.init(AssetsModule());

      final assetsService = Modular.get<AssetsServiceBase>();
      final locationsService = Modular.get<ServiceBase<Location>>();
      print("deu");

      // #endregion
    });
  });
}
