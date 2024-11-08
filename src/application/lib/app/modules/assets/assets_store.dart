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

  // #region Members 'Assets' :: assetsService, assets, getAssets()

  /// Serviço de recursos
  @override
  late AssetsServiceBase assetsService;

  /// Ativos
  @override
  @observable
  late List<Asset> assets;

  /// Buscar ativos
  @override
  @action
  Future<void> getAssets() async {
    try {
      this.dispatchIsLoading(true);

      this.assets = await this.assetsService.getAll();
      this.locations = await this.locationsService.getAll();

      await this.refreshAssetsTree();

      this.dispatchIsLoading(false);
    } catch (exception) {
      throw Exception('Fail in getAssets(): $exception');
    }
  }

  // #endregion

  // #region Members 'Assets Tree' :: assetsTree, refreshAssetsTree(), expandedTreeItems(), toggleExpandedItem()

  /// Árvore
  @override
  @observable
  late AssetsTree assetsTree;

  /// Atualizar
  @override
  @action
  Future<void> refreshAssetsTree() async {
    try {
      this.dispatchIsLoading(true);

      await Future.delayed(const Duration(seconds: 1));

      List<AssetFilter> filters = this.selectedCustomFilters.toList();
      if (this.textSearchFilter.textSearch.isNotEmpty) {
        filters.add(this.textSearchFilter);
      }

      this.assetsTree = AssetsTree(
        locations: this.locations,
        assets: this.assets,
        filters: filters,
      );
      await this.assetsTree.build();

      this.expandedTreeItems =
          this.hasFilters ? this.assetsTree.allTreeItems : [];

      this.dispatchIsLoading(false);
    } catch (exception) {
      throw Exception('Fail in refreshAssetsTree(): $exception');
    }
  }

  /// Itens expandidos
  @override
  @observable
  List<TreeItem> expandedTreeItems = <TreeItem>[];

  /// Alternar item expandido
  @override
  @action
  void toggleExpandedItem(TreeItem treeItem) {
    try {
      List<TreeItem> treeItems = this.expandedTreeItems.toList();

      if (treeItems.contains(treeItem)) {
        treeItems.remove(treeItem);
      } else {
        treeItems.add(treeItem);
      }

      this.expandedTreeItems = treeItems.toList();
    } on Exception catch (exception) {
      throw Exception("Fail in toggleExpandedItem(): $exception");
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
