import 'dart:convert';
import 'dart:io';

import 'package:domain/domain.dart';
import 'package:domain/src/models/tree/assets_tree.dart';
import 'package:domain/src/models/tree/assets_tree_item.dart';
import 'package:test/test.dart';

void main() {
  group('Tree Assets', () {
    late List<Asset> assets;
    late List<Location> locations;
    setUp(() async {
      final File assetsFile = File('assets/assets.json');
      String jsonString = await assetsFile.readAsString();
      List<dynamic> items = json.decode(jsonString);
      assets = items.map((json) => Asset.fromJson(json)).toList();

      final File locationsFile = File('assets/locations.json');
      jsonString = await locationsFile.readAsString();
      items = json.decode(jsonString);
      locations = items.map((json) => Location.fromJson(json)).toList();
    });

    test('Must build tree assets', () async {
      AssetsTree assetsTree = AssetsTree(locations: locations, assets: assets);
      assetsTree.buildTree();

      printTree(assetsTree.treeItems);

      expect(assetsTree.treeItems, isA<List<AssetsTreeItem>>());
    });
  });
}

void printTree(List<AssetsTreeItem> treeItems, [String prefix = '']) {
  for (AssetsTreeItem treeItem in treeItems) {
    print('$prefix${treeItem.description}');
    printTree(treeItem.children, '$prefix  ');
  }
}
