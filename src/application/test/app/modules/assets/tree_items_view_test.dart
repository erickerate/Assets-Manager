import 'dart:convert';
import 'dart:io';

import 'package:application/app/modules/assets/assets_module.dart';
import 'package:application/app/modules/assets/widgets/tree/tree_items_view.dart';
import 'package:application/app/widgets/skeleton_loader_view.dart';
import 'package:darq/darq.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tree_items_view_test.mocks.dart';

@GenerateMocks([AssetsServiceBase])
@GenerateMocks([LocationsServiceBase])
void main() {
  final mockAssetsService = MockAssetsServiceBase();
  final mockLocationsService = MockLocationsServiceBase();
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

  group('TreeItemsView ::', () {
    testWidgets("Must correctly load the assets listing view",
        (WidgetTester tester) async {
      // #region Arrange

      when(mockAssetsService.getAll()).thenAnswer((_) async => assets);
      when(mockLocationsService.getAll()).thenAnswer((_) async => locations);

      Modular.replaceInstance<AssetsServiceBase>(mockAssetsService);
      Modular.replaceInstance<LocationsServiceBase>(mockLocationsService);
      Modular.init(AssetsModule());
      Modular.get<IAssetsStore>().company =
          Company(id: "662fd0ee639069143a8fc387", name: "Jaguar");

      // #endregion

      // #region Act

      await tester.pumpWidget(
        const MaterialApp(
          home: TreeItemsView(),
        ),
      );

      // #endregion

      // #region Assert

      // #region Raízes da árvore

      expect(
        find.byType(SkeletonLoaderView),
        findsOneWidget,
        reason:
            "SkeletonLoaderView must be visible before loading asset listing",
      );

      await tester.pumpAndSettle();

      expect(
        find.byType(SkeletonLoaderView),
        findsNothing,
        reason:
            "SkeletonLoaderView must be invisible after loading asset listing",
      );

      List<ITreeItemStore> treeItemStores =
          Modular.get<IAssetsStore>().treeItemStores.values.toList();
      for (ITreeItemStore treeItemStore
          in treeItemStores.where((w) => w.visible)) {
        expect(
          find.text(treeItemStore.treeItem.description),
          findsOneWidget,
          reason: "Visible asset must be included in the listing",
        );
      }

      // #endregion

      // #region Expande o item

      ITreeItemStore parentTreeItemStore = treeItemStores.firstWhereOrDefault(
          (w) => w.visible && w.treeItem.children.isNotEmpty)!;

      final textFinder = find.text(parentTreeItemStore.treeItem.description);
      final parentRowFinder = find.ancestor(
        of: textFinder,
        matching: find.byType(Row),
      );
      final iconButtonFinder = find.descendant(
        of: parentRowFinder,
        matching: find.byType(IconButton),
      );
      await tester.tap(iconButtonFinder);
      await tester.pump();

      List<ITreeItemStore> children = treeItemStores
          .where((w) => w.treeItem.parent == parentTreeItemStore.treeItem)
          .toList();
      for (ITreeItemStore child in children) {
        expect(
          find.text(child.treeItem.description),
          findsOneWidget,
          reason:
              "The child asset must be visible after the parent has been expanded",
        );
      }

      await tester.tap(iconButtonFinder);
      await tester.pump();

      for (ITreeItemStore child in children) {
        expect(
          find.text(child.treeItem.description),
          findsNothing,
          reason:
              "Child asset must have been removed from the list after collapsing the parent",
        );
      }

      // #endregion

      // #endregion
    });
  });
}
