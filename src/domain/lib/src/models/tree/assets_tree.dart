import 'package:domain/domain.dart';

/// Modelo para árvore de ativos
class AssetsTree {
  // #region Constructors

  /// Modelo para árvore de ativos
  AssetsTree({
    required this.locations,
    required this.assets,
  }) {
    this.buildTree();
  }

  // #endregion

  // #region Members 'Entities' :: locations, assets

  /// Localizações
  final List<Location> locations;

  /// Ativos
  final List<Asset> assets;

  // #endregion

  // #region Members 'Tree' :: treeItems, buildTree()

  /// Itens
  List<AssetsTreeItem> treeItems = <AssetsTreeItem>[];

  /// Construir árvore
  void buildTree() {
    try {
      // #region 1. Cria itens Localizações / Recursos

      this.treeItems.clear();
      List<AssetsTreeItem> allTreeItems = <AssetsTreeItem>[];

      List<AssetsTreeItem> locationTreeItems = this
          .locations
          .map((location) => AssetsTreeItem.fromLocation(location))
          .toList();
      allTreeItems.addAll(locationTreeItems);

      List<AssetsTreeItem> assetTreeItems =
          this.assets.map((asset) => AssetsTreeItem.fromAsset(asset)).toList();
      allTreeItems.addAll(assetTreeItems);

      // #endregion

      // #region 2 Constrói árvore

      List<AssetsTreeItem> orphanTreeItems =
          allTreeItems.where((w) => w.parentId == null).toList();
      for (AssetsTreeItem orphanTreeItem in orphanTreeItems) {
        this.addChildren(allTreeItems, orphanTreeItem);

        this.treeItems.add(orphanTreeItem);
      }

      // #endregion
    } on Exception catch (exception) {
      throw Exception("Fail in buildTree(): $exception");
    }
  }

  /// Adicionar filhos
  void addChildren(List<AssetsTreeItem> allTreeItems, AssetsTreeItem treeItem) {
    try {
      for (AssetsTreeItem child
          in allTreeItems.where((w) => w.parentId == treeItem.id)) {
        child.parent = treeItem;
        treeItem.children.add(child);
        this.addChildren(allTreeItems, child);
      }
    } on Exception catch (exception) {
      throw Exception("Fail in getChildren(): $exception");
    }
  }

  // #endregion
}
