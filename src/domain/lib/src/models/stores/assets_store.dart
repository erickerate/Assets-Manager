import 'package:domain/domain.dart';

/// Interface para loja de ativos
abstract class IAssetsStore implements StoreBase {
  // #region Members 'Assets' :: assetsService, assetsTree, assets, getAssets(), refreshAssetsTree()

  /// Serviço de recursos
  late AssetsServiceBase assetsService;

  /// Árvore
  late AssetsTree assetsTree;

  /// Ativos
  late List<Asset> assets;

  /// Buscar ativos
  Future<void> getAssets();

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
