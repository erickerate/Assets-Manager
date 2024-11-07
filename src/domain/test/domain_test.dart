import 'dart:convert';
import 'dart:io';

import 'package:domain/domain.dart';
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
      AssetsTree assetsTree = AssetsTree(
        locations: locations,
        assets: assets,
        filters: [],
      );
      assetsTree.build();

      printTree(assetsTree.firstBorns);

      expect(assetsTree.firstBorns, isA<List<TreeItem>>());
    });
  });
}

void printTree(List<TreeItem> treeItems, [String prefix = '']) {
  for (TreeItem treeItem in treeItems) {
    print('$prefix${treeItem.description}');
    printTree(treeItem.children, '$prefix  ');
  }
}
