import 'package:domain/domain.dart';

/// Interface para loja de ativos
abstract class IAssetsStore implements StoreBase {
  // #region Members 'Assets' :: assetsService, assets, getAssets()

  /// Serviço de recursos
  late AssetsServiceBase assetsService;

  /// Ativos
  late List<Asset> assets;

  /// Buscar ativos
  Future<void> getAssets();

  // #endregion

  // #region Members 'Assets Tree' :: assetsTree, expandedTreeItems, toggleExpandedItem, refreshAssetsTree()

  /// Árvore
  late AssetsTree assetsTree;

  /// Itens expandidos
  late List<TreeItem> expandedTreeItems;

  /// Alternar item expandido
  void toggleExpandedItem(TreeItem treeItem);

  /// Atualizar
  Future<void> refreshAssetsTree();

  // #endregion

  // #region Members 'Locations' :: locationsService, locations

  /// Serviço de localizações
  late ServiceBase<Location> locationsService;

  /// Localizações
  late List<Location> locations;

  // #endregion

  // #region Members 'Custom Filters' :: selectedCustomFilters, selectCustomFilter(), hasFilters

  /// Filtros selecionados
  List<AssetFilter> selectedCustomFilters = <AssetFilter>[];

  /// Selecionar filtro
  Future<void> selectCustomFilter(AssetFilter filter);

  /// Possui filtros selecionados?
  bool get hasFilters;

  // #endregion

  // #region Members 'Text Filter' :: textSearchFilter, onTextSearchFilterChanged()

  /// Filtro de texto
  TextSearchFilter textSearchFilter = TextSearchFilter();

  /// Ao buscar pelo filtro de texto
  Future<void> onTextSearchFilterChanged(String value);

  // #endregion
}
