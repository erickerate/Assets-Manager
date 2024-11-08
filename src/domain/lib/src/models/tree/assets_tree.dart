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
  });

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

  // #region Members 'Utils' :: buildFirstBorns(), getFirstBorn()

  /// Construir primogênitos
  List<TreeItem> buildFirstBorns(List<TreeItem> treeItems) {
    try {
      List<TreeItem> firstBorns = <TreeItem>[];

      for (TreeItem treeItem in treeItems) {
        TreeItem firstBorn = this.buildFirstBorn(treeItem);
        firstBorns.add(firstBorn);
      }

      firstBorns = firstBorns.distinct().toList();
      return firstBorns;
    } on Exception catch (exception) {
      throw Exception("Fail in buildFirstBorns(): $exception");
    }
  }

  /// Construir pai
  TreeItem buildFirstBorn(TreeItem treeItem) {
    try {
      if (treeItem.parentId != null) {
        TreeItem parent = this
            .allTreeItems
            .firstWhereOrDefault((w) => w.id == treeItem.parentId)!;

        treeItem.parent = parent;
        if (!parent.children.contains(treeItem)) {
          parent.children.add(treeItem);
        }

        return this.buildFirstBorn(parent);
      }

      return treeItem;
    } on Exception catch (exception) {
      throw Exception("Fail in buildFirstBorn(): $exception");
    }
  }

  // #endregion

  // #region Members 'Tree' :: firstBorns, allTreeItems, build()

  /// Itens primogênitos
  List<TreeItem> firstBorns = <TreeItem>[];

  /// Todos itens
  List<TreeItem> allTreeItems = <TreeItem>[];

  /// Construir árvore
  Future<void> build() async {
    try {
      // #region 1. Cria itens Localizações / Recursos

      DateTime start = DateTime.now();

      this.firstBorns.clear();
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

      DateTime end = DateTime.now();
      print(
        "Passo 1: Criar itens Localizações/Recursos (${end.difference(start).inSeconds} s)",
      );

      // #endregion

      // #region 2. Filtrar itens

      start = DateTime.now();

      if (this.filters.isEmpty) {
        filteredTreeItems = this.allTreeItems;
      } else {
        for (TreeItem treeItem in this.allTreeItems) {
          bool meetsAnyFilter =
              this.filters.all((filter) => filter.meets(treeItem));
          if (meetsAnyFilter) {
            filteredTreeItems.add(treeItem);
          }
        }
      }

      end = DateTime.now();
      print(
        "Passo 2: Filtrar itens (${end.difference(start).inSeconds} s)",
      );

      // #endregion

      // #region 3. Constrói estrutura

      start = DateTime.now();

      this.firstBorns = this.buildFirstBorns(filteredTreeItems);

      end = DateTime.now();
      print(
        "Passo 3: Constrói estrutura (${end.difference(start).inSeconds} s)",
      );

      // #endregion
    } on Exception catch (exception) {
      throw Exception("Fail in build(): $exception");
    }
  }

  // #endregion
}
