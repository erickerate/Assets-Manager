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
  Future<void> buildDescendants(
    List<TreeItem> descendants,
    TreeItem treeItem,
  ) async {
    try {
      DateTime start = DateTime.now();

      // Filhos do item vigente
      List<TreeItem> children =
          this.allTreeItems.where((w) => w.parentId == treeItem.id).toList();

      DateTime end = DateTime.now();
      print('Passo 4.1: ${end.difference(start).inSeconds} s');

      print("children: ${children.length}");
      for (TreeItem child in children) {
        start = DateTime.now();
        List<TreeItem> childDescendants = this.getDescendants(child);
        end = DateTime.now();
        print('Passo 4.2: ${end.difference(start).inSeconds} s');

        start = DateTime.now();
        bool isDescendant = childDescendants
            .any((descendant) => descendants.contains(descendant));
        end = DateTime.now();
        print('Passo 4.3: ${end.difference(start).inSeconds} s');

        if (!isDescendant) continue;

        // Navegação
        child.parent = treeItem;
        treeItem.children.add(child);

        this.buildDescendants(descendants, child);
      }
    } on Exception catch (exception) {
      throw Exception("Fail in buildDescendants(): $exception");
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
      print('Passo 1: ${end.difference(start).inSeconds} s');

      // #endregion

      // #region 2. Itens filtrados

      start = DateTime.now();

      // Tipo / Estado
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
      print('Passo 2: ${end.difference(start).inSeconds} s');

      // #endregion

      // #region 3. Obtém primogênitos

      start = DateTime.now();

      this.firstBorns = this.getFirstBorns(filteredTreeItems);
      end = DateTime.now();
      print('Passo 3: ${end.difference(start).inSeconds} s');

      // #endregion

      // #region 4. Constrói árvore a partir dos primogênitos

      for (TreeItem firstBorn in this.firstBorns) {
        this.buildDescendants(filteredTreeItems, firstBorn);
      }

      // #endregion

      // // #region 4. Constrói árvore

      // start = DateTime.now();

      // for (TreeItem firstBorn in firstBorns) {
      //   this.buildDescendants(filteredTreeItems, firstBorn);

      //   this.filteredTreeItems.add(firstBorn);
      // }
      // end = DateTime.now();
      // print('Passo 4: ${end.difference(start).inSeconds} s');

      // // #endregion
    } on Exception catch (exception) {
      throw Exception("Fail in build(): $exception");
    }
  }

  // #endregion
}
