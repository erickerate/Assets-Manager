import 'package:darq/darq.dart';
import 'package:domain/domain.dart';
import 'package:domain/src/models/assets/tree_item.dart';

/// Modelo para árvore de ativos
class AssetsTree {
  // #region Constructors

  /// Modelo para árvore de ativos
  AssetsTree({
    required this.locations,
    required this.assets,
  });

  // #endregion

  // #region Members 'Entities' :: locations, assets

  /// Localizações
  final List<Location> locations;

  /// Ativos
  final List<Asset> assets;

  // #endregion

  // #region Members 'Tree' :: treeItems, buildTree()

  /// Itens
  List<TreeItem> treeItems = <TreeItem>[];

  /// Construir árvore
  void buildTree() {
    try {
      // #region 1. Cria itens Localizações / Recursos

      this.treeItems.clear();
      List<TreeItem> allTreeItems = <TreeItem>[];

      List<TreeItem> locationTreeItems = this
          .locations
          .map((location) => TreeItem.fromLocation(location))
          .toList();
      allTreeItems.addAll(locationTreeItems);

      List<TreeItem> assetTreeItems =
          this.assets.map((asset) => TreeItem.fromAsset(asset)).toList();
      allTreeItems.addAll(assetTreeItems);

      // #endregion

      // #region 2 Constrói árvore

      List<TreeItem> orphanTreeItems =
          allTreeItems.where((w) => w.parentId == null).toList();
      for (TreeItem orphanTreeItem in orphanTreeItems) {
        this.addChildren(allTreeItems, orphanTreeItem);

        this.treeItems.add(orphanTreeItem);
      }

      // #endregion
    } on Exception catch (exception) {
      throw Exception("Fail in buildTree(): $exception");
    }
  }

  /// Adicionar filhos
  void addChildren(List<TreeItem> allTreeItems, TreeItem treeItem) {
    try {
      for (TreeItem child
          in allTreeItems.where((w) => w.parentId == treeItem.id)) {
        treeItem.children.add(child);
        this.addChildren(allTreeItems, child);
      }
    } on Exception catch (exception) {
      throw Exception("Fail in getChildren(): $exception");
    }
  }

  // #endregion
}
