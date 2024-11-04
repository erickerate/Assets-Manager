import 'package:domain/domain.dart';
import 'package:darq/darq.dart';

/// Modelo para árvore de ativos
class AssetsTree {
  // #region Constructors

  /// Modelo para árvore de ativos
  AssetsTree({
    required this.locations,
    required this.assets,
    required this.filters,
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

  // #region Members 'Filters' :: filters

  /// Filtros
  final List<AssetFilter> filters;

  // #endregion

  // #region Members 'Utils' :: getFirstBorns(), getFirstBorn(), buildDescendants(), getDescendants()

  /// Obter primogênitos
  List<TreeItem> getFirstBorns(List<TreeItem> treeItems) {
    try {
      List<TreeItem> firstBorns = <TreeItem>[];
      for (TreeItem treeItem in treeItems) {
        TreeItem firstBorn = this.getFirstBorn(treeItem);
        firstBorns.add(firstBorn);
      }

      firstBorns = firstBorns.distinct().toList();
      return firstBorns;
    } on Exception catch (exception) {
      throw Exception("Fail in getFirstBorns(): $exception");
    }
  }

  /// Obter primogênito
  TreeItem getFirstBorn(TreeItem treeItem) {
    try {
      if (treeItem.parentId != null) {
        TreeItem parent = this
            .allTreeItems
            .firstWhereOrDefault((w) => w.id == treeItem.parentId)!;
        return this.getFirstBorn(parent);
      }

      return treeItem;
    } on Exception catch (exception) {
      throw Exception("Fail in getFirstBorn(): $exception");
    }
  }

  /// Construir descendentes
  void buildDescendants(
    List<TreeItem> descendants,
    TreeItem treeItem,
  ) {
    try {
      // Filhos do item vigente
      List<TreeItem> children =
          this.allTreeItems.where((w) => w.parentId == treeItem.id).toList();

      for (TreeItem child in children) {
        List<TreeItem> childDescendants = this.getDescendants(child);

        bool isDescendant = childDescendants
            .any((descendant) => descendants.contains(descendant));

        if (!isDescendant) continue;

        // Navegação
        child.parent = treeItem;
        treeItem.children.add(child);

        this.buildDescendants(descendants, child);
      }
    } on Exception catch (exception) {
      throw Exception("Fail in addDescendants(): $exception");
    }
  }

  /// Obter descendentes
  List<TreeItem> getDescendants(TreeItem treeItem) {
    try {
      List<TreeItem> childs = <TreeItem>[];
      childs.add(treeItem);

      for (TreeItem child
          in this.allTreeItems.where((w) => w.parentId == treeItem.id)) {
        childs.addAll(this.getDescendants(child));
      }

      return childs;
    } on Exception catch (exception) {
      throw Exception("Fail in getDescendants(): $exception");
    }
  }

  // #endregion

  // #region Members 'Tree' :: treeItems, buildTree()

  /// Itens filtrados
  List<TreeItem> filteredTreeItems = <TreeItem>[];

  /// Todos itens
  List<TreeItem> allTreeItems = <TreeItem>[];

  /// Construir árvore
  void buildTree() {
    try {
      // #region 1. Cria itens Localizações / Recursos

      this.filteredTreeItems.clear();
      this.allTreeItems.clear();
      List<TreeItem> filteredTreeItems = <TreeItem>[];

      List<TreeItem> locationTreeItems = this
          .locations
          .map((location) => TreeItem.fromLocation(location))
          .toList();
      this.allTreeItems.addAll(locationTreeItems);

      List<TreeItem> assetTreeItems =
          this.assets.map((asset) => TreeItem.fromAsset(asset)).toList();
      this.allTreeItems.addAll(assetTreeItems);

      // #endregion

      // #region 2. Itens filtrados

      // Tipo / Estado
      if (this.filters.isEmpty) {
        filteredTreeItems = this.allTreeItems;
      } else {
        for (TreeItem treeItem in this.allTreeItems) {
          bool meetsAnyFilter =
              this.filters.any((filter) => filter.meets(treeItem));
          if (meetsAnyFilter) {
            filteredTreeItems.add(treeItem);
          }
        }
      }

      // #endregion

      // #region 3. Obtém primogênitos

      List<TreeItem> firstBorns = this.getFirstBorns(filteredTreeItems);

      // #endregion

      // #region 4. Constrói árvore

      for (TreeItem firstBorn in firstBorns) {
        this.buildDescendants(filteredTreeItems, firstBorn);

        this.filteredTreeItems.add(firstBorn);
      }

      // #endregion
    } on Exception catch (exception) {
      throw Exception("Fail in buildTree(): $exception");
    }
  }

  // #endregion
}
