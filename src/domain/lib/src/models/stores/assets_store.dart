import 'dart:isolate';

import 'package:domain/domain.dart';

/// Interface para loja de ativos
abstract class IAssetsStore implements StoreBase {
  // #region Members 'Assets' :: assetsService, assets

  /// Serviço de recursos
  late AssetsServiceBase assetsService;

  /// Ativos
  late List<Asset> assets;

  // #endregion

  // #region Members 'Isolate' :: listen(), isolate, receivePort

  /// Ouvir
  void listen(dynamic data);

  Isolate? isolate;

  final ReceivePort receivePort = ReceivePort();

  // #endregion

  // #region Members 'Assets Tree' :: treeItemStores, buildTreeAssets(), refreshAssetsTree()

  /// Itens
  Map<String, ITreeItemStore> treeItemStores = <String, ITreeItemStore>{};

  /// Construir árvore de ativos
  Future<void> buildTreeAssets();

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
