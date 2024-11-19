import 'dart:convert';
import 'dart:io';

import 'package:darq/darq.dart';
import 'package:domain/domain.dart';
import 'package:test/test.dart';

void main() {
  group("Tree Assets ::", () {
    // #region Setup

    late List<Asset> assets;
    late List<Location> locations;

    AssetsTree? assetsTree;
    setUp(() async {
      // Ativos
      final File assetsFile = File('assets/assets.json');
      String jsonString = await assetsFile.readAsString();
      List<dynamic> items = json.decode(jsonString);
      assets = items.map((json) => Asset.fromJson(json)).toList();

      // Localizações
      final File locationsFile = File('assets/locations.json');
      jsonString = await locationsFile.readAsString();
      items = json.decode(jsonString);
      locations = items.map((json) => Location.fromJson(json)).toList();
    });

    // #endregion

    test(
        'Assets tree needs to be built and must contain the correct number of items',
        () async {
      // #region Act

      assetsTree = AssetsServiceBase.buildAssetsTree(assets, locations);

      // #endregion

      // #region Assert

      int itemsCount = locations.length + assets.length;
      expect(assetsTree, isNotNull);
      expect(assetsTree!.stackItems, isA<List<TreeItem>>());
      expect(assetsTree!.stackItems.length, itemsCount);

      // #endregion
    });

    test('Assets tree does not contain repeated items', () async {
      // #region Assert

      expect(assetsTree, isNotNull);
      List<String> treeItemIds = assetsTree!.stackItems
          .select((treeItem, index) => treeItem.id)
          .toList();
      expect(Set.from(treeItemIds).length, treeItemIds.length);

      // #endregion
    });

    test('The parent/child tree hierarchy must be correct', () async {
      // #region Assert

      expect(assetsTree, isNotNull);
      expect(validateAssetsTreeHierarchy(assetsTree!), isTrue);

      // #endregion
    });

    test('The text filter should work correctly', () async {
      // #region Arrange

      TextSearchFilter textSearchFilter =
          TextSearchFilter(textSearch: "PRODUCTION AREA - RAW");

      // #endregion

      // #region Act / Assert

      expect(assetsTree, isNotNull);
      for (TreeItem treeItem in assetsTree!.stackItems) {
        treeItem.visible = false;
      }
      List<TreeItem> filteredTreeItems =
          getFilteredTreeItems(assetsTree!.stackItems, [textSearchFilter]);

      // #endregion

      // #region Assert

      TreeItem? treeItem = filteredTreeItems.firstOrDefault();
      expect(treeItem, isNotNull);
      expect(filteredTreeItems.length, 1);
      expect(treeItem!.id, "65674204664c41001e91ecb4");

      // #endregion
    });

    test('The sensor energy filter should work correctly', () async {
      // #region Arrange

      EnergySensorTypeFilter energySensorTypeFilter = EnergySensorTypeFilter();

      // #endregion

      // #region Act / Assert

      expect(assetsTree, isNotNull);
      for (TreeItem treeItem in assetsTree!.stackItems) {
        treeItem.visible = false;
      }
      List<TreeItem> filteredTreeItems = getFilteredTreeItems(
          assetsTree!.stackItems, [energySensorTypeFilter]);

      // #endregion

      // #region Assert

      expect(filteredTreeItems.length, 1);

      // #endregion
    });

    test('The critical state filter should work correctly', () async {
      // #region Arrange

      CriticalAssetStateFilter criticalAssetStateFilter =
          CriticalAssetStateFilter();

      // #endregion

      // #region Act

      expect(assetsTree, isNotNull);
      for (TreeItem treeItem in assetsTree!.stackItems) {
        treeItem.visible = false;
      }
      List<TreeItem> filteredTreeItems = getFilteredTreeItems(
          assetsTree!.stackItems, [criticalAssetStateFilter]);

      // #endregion

      // #region Assert

      expect(filteredTreeItems.length, 5);

      // #endregion
    });

    test('The tree stack linearization is consistent with the item hierarchy',
        () {
      expect(assetsTree, isNotNull);
      List<TreeItem> treeItems = assetsTree!.map.values.toList();
      expect(
        assetsTree!.stackItems.toSet(),
        equals(treeItems.toSet()),
        reason:
            'Linearized list must contain exactly the same items as the tree.',
      );

      for (int i = 0; i < assetsTree!.stackItems.length; i++) {
        TreeItem current = assetsTree!.stackItems[i];

        for (TreeItem child in current.children) {
          int childIndex = assetsTree!.stackItems.indexOf(child);
          expect(
            childIndex > i,
            isTrue,
            reason:
                'Child ${child.description} must appear after its parent ${current.description}.',
          );
        }
      }
    });
  });
}

/// Validar hierarquia dos itens
bool validateAssetsTreeHierarchy(AssetsTree assetsTree) {
  for (TreeItem treeItem in assetsTree.stackItems) {
    if (treeItem.parentId == null) continue;

    TreeItem parentTreeItem = assetsTree.map[treeItem.parentId]!;
    bool isValid = parentTreeItem.children.contains(treeItem);

    if (!isValid) return false;
  }

  return true;
}
