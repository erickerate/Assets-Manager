import 'dart:isolate';

import 'package:application/app/modules/assets/isolates/apply_filters_isolate.dart';
import 'package:domain/domain.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'assets_store.g.dart';

/// Implementação da loja de recursos com MobX
class AssetsStore = AssetsStoreBase with _$AssetsStore;

/// Implementação da loja de recursos com MobX
abstract class AssetsStoreBase with Store implements IAssetsStore {
  // #region Constructors

  AssetsStoreBase() {
    this.assetsService = Modular.get<AssetsServiceBase>();
    this.locationsService = Modular.get<ServiceBase<Location>>();
  }

  // #endregion

  // #region Members 'Isolate' :: isolate, receivePort, listen()

  @override
  Isolate? isolate;

  @override
  final ReceivePort receivePort = ReceivePort();

  @override
  void listen(dynamic data) {
    try {
      if (data is List<TreeItem>) {
        List<TreeItem> visibleTreeItems = data;

        for (TreeItem treeItem in visibleTreeItems) {
          ITreeItemStore treeItemStore = this.treeItemStores[treeItem.id]!;
          treeItemStore.setVisible(true);
          treeItemStore.setExpanded(treeItem.isFixedExpanded);
          treeItemStore.setIsFixedExpanded(treeItem.isFixedExpanded);
        }
      }

      this.dispatchIsLoading(false);
    } catch (exception) {
      throw Exception("Fail in listen(): $exception");
    }
  }

  // #endregion

  // #region Members 'Assets' :: assetsService, assets

  /// Serviço de recursos
  @override
  late AssetsServiceBase assetsService;

  /// Ativos
  @override
  @observable
  late List<Asset> assets;

  // #endregion

  // #region Members 'Assets Tree' :: treeItemStores, buildTreeAssets(), refreshAssetsTree(), expandedTreeItems(), toggleExpandedItem()

  /// Itens
  @override
  @observable
  late Map<String, ITreeItemStore> treeItemStores = <String, ITreeItemStore>{};

  /// Construir árvore de ativos
  @override
  @action
  Future<void> buildTreeAssets() async {
    try {
      this.dispatchIsLoading(true);

      Map<String, ITreeItemStore> treeItemStores = <String, ITreeItemStore>{};
      this.assets = await this.assetsService.getAll();
      this.locations = await this.locationsService.getAll();

      AssetsTree assetsTree =
          this.assetsService.buildAssetsTree(this.assets, this.locations);
      for (TreeItem treeItem in assetsTree.allItems) {
        ITreeItemStore treeItemStore = Modular.get<ITreeItemStore>();
        treeItemStore.treeItem = treeItem;
        treeItemStores.putIfAbsent(
          treeItem.id,
          () => treeItemStore,
        );
      }

      this.treeItemStores = treeItemStores;

      this.dispatchIsLoading(false);
    } catch (exception) {
      throw Exception('Fail in buildTreeAssets(): $exception');
    }
  }

  /// Atualizar
  @override
  @action
  Future<void> refreshAssetsTree() async {
    try {
      this.dispatchIsLoading(true);

      await Future.delayed(const Duration(seconds: 1));

      // Reset
      bool mustMaintainRootsVisible = !this.hasFilters;
      for (ITreeItemStore treeItemStore in this.treeItemStores.values) {
        bool visible =
            mustMaintainRootsVisible && treeItemStore.treeItem.isRoot;
        treeItemStore.setVisible(visible);
        treeItemStore.setIsFixedExpanded(false);
        treeItemStore.setExpanded(false);
      }
      if (!this.hasFilters) {
        this.dispatchIsLoading(false);
        return;
      }

      // Finaliza o isolate anterior, se existir
      isolate?.kill(priority: Isolate.immediate);

      // Inicia um novo isolate com a tarefa de processamento
      List<AssetFilter> filters = this.selectedCustomFilters.toList();
      if (this.textSearchFilter.textSearch.isNotEmpty) {
        filters.add(this.textSearchFilter);
      }
      final isolateModel = IsolateModel(
        this.treeItemStores.values.map((m) => m.treeItem).toList(),
        filters,
        receivePort.sendPort,
      );
      isolate =
          await Isolate.spawn<IsolateModel>(executeFiltersTask, isolateModel);
    } catch (exception) {
      this.dispatchIsLoading(false);
      throw Exception('Fail in refreshAssetsTree(): $exception');
    }
  }

  // #endregion

  // #region Members 'Locations' :: locationsService, locations

  /// Serviço de localizações
  @override
  late ServiceBase<Location> locationsService;

  /// Localizações
  @override
  @observable
  late List<Location> locations;

  // #endregion

  // #region Members 'Custom Filters' :: selectedCustomFilters, selectCustomFilter(), hasFilters

  /// Filtros selecionados
  @override
  @observable
  List<AssetFilter> selectedCustomFilters = <AssetFilter>[];

  /// Selecionar filtro
  @override
  @action
  Future<void> selectCustomFilter(AssetFilter filter) async {
    try {
      List<AssetFilter> selectedFilters = this.selectedCustomFilters.toList();
      if (selectedFilters.contains(filter)) {
        selectedFilters.remove(filter);
      } else {
        selectedFilters.add(filter);
      }

      this.selectedCustomFilters = selectedFilters.toList();
    } catch (exception) {
      throw Exception('Fail in selectCustomFilter(): $exception');
    }
  }

  /// Possui filtros selecionados?
  @override
  @computed
  bool get hasFilters =>
      this.selectedCustomFilters.isNotEmpty || this.textSearchFilter.hasFilter;

  // #endregion

  // #region Members 'Text Filter' :: textSearchFilter, onTextSearchFilterChanged()

  /// Filtro de texto
  @override
  @observable
  TextSearchFilter textSearchFilter = TextSearchFilter();

  /// Ao buscar pelo filtro de texto
  @override
  @action
  Future<void> onTextSearchFilterChanged(String value) async {
    try {
      this.textSearchFilter = TextSearchFilter(textSearch: value);
      this.refreshAssetsTree();
    } catch (exception) {
      throw Exception('Fail in onTextSearchFilterChanged(): $exception');
    }
  }

  // #endregion

  // #region Members 'State' :: isLoading, dispatchIsLoading

  /// Está carregando?
  @override
  @observable
  bool isLoading = true;

  /// Despachar carregando
  @override
  @action
  Future<void> dispatchIsLoading(bool isLoading) async {
    try {
      this.isLoading = isLoading;
    } catch (exception) {
      throw Exception('Fail in dispatchIsLoading(): $exception');
    }
  }

  // #endregion
}
