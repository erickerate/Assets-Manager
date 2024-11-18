import 'package:darq/darq.dart';
import 'package:domain/domain.dart';

/// Serviço abstrato para recursos
abstract class AssetsServiceBase extends ServiceBase<Asset> {
  // #region Members 'Owner' :: company

  /// Empresa
  late Company company;

  // #endregion

  // #region Members 'Filters' :: customFilters

  /// Filtros customizados
  List<AssetFilter> get customFilters {
    if (this._customfilters == null) {
      this._customfilters = <AssetFilter>[];
      this._customfilters!.add(EnergySensorTypeFilter());
      this._customfilters!.add(CriticalAssetStateFilter());
    }

    return this._customfilters!;
  }

  List<AssetFilter>? _customfilters;

  // #endregion

  // #region Members 'Tree' :: buildAssetsTree()

  /// Construir árvore de ativos
  AssetsTree buildAssetsTree(List<Asset> assets, List<Location> locations) {
    try {
      // #region 1. Cria itens Localizações / Recursos

      AssetsTree assetsTree = AssetsTree();
      TreeItem treeItem;
      List<TreeItem> stackItems = <TreeItem>[];
      DateTime start = DateTime.now();

      // Localizações
      for (Location location in locations) {
        treeItem = TreeItem.fromLocation(location);
        assetsTree.map.putIfAbsent(location.id!, () => treeItem);
      }

      // Ativos
      for (Asset asset in assets) {
        treeItem = TreeItem.fromAsset(asset);
        assetsTree.map.putIfAbsent(asset.id!, () => treeItem);
      }

      DateTime end = DateTime.now();
      print(
        "Passo 1: Criar itens Localizações/Recursos (${end.difference(start).inSeconds} s)",
      );

      // #endregion

      // #region 2. Constrói estrutura

      start = DateTime.now();

      // Navegação O(n)
      TreeItem parentTreeItem;
      for (TreeItem treeItem in assetsTree.map.values) {
        if (treeItem.parentId == null) {
          stackItems.add(treeItem);
        } else {
          parentTreeItem = assetsTree.map[treeItem.parentId]!;
          parentTreeItem.addChild(treeItem);
          treeItem.parent = parentTreeItem;
        }
      }

      // Linearização => Usado para listagem! O(n)
      stackItems = stackItems.reversed.toList();
      while (stackItems.isNotEmpty) {
        final TreeItem current = stackItems.removeLast();
        assetsTree.stackItems.add(current);

        if (current.children.isNotEmpty) {
          stackItems.addAll(current.children.reversed);
        }
      }

      // Caminho até a raiz => Usado para filtros! O(n)
      List<TreeItem> orderedTreeItems =
          assetsTree.stackItems.orderBy((o) => o.level).toList();
      for (TreeItem treeItem in orderedTreeItems) {
        if (treeItem.parentId == null) continue;

        parentTreeItem = assetsTree.map[treeItem.parentId]!;
        treeItem.ascendants = [...parentTreeItem.ascendants, parentTreeItem];
      }

      end = DateTime.now();
      print(
        "Passo 2: Constrói estrutura (${end.difference(start).inSeconds} s)",
      );

      return assetsTree;

      // #endregion
    } on Exception catch (exception) {
      throw Exception("Fail in buildAssetsTree(): $exception");
    }
  }

  // #endregion
}
