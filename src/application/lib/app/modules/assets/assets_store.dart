import 'package:domain/domain.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'assets_store.g.dart';

/// Loja de recursos
class AssetsStore = _AssetsStoreBase with _$AssetsStore;

/// Loja de recursos
abstract class _AssetsStoreBase with Store {
  // #region Constructors

  _AssetsStoreBase() {
    this.assetsService = Modular.get<IAssetsService>();
    this.locationsService = Modular.get<IService<Location>>();
  }

  // #endregion

  // #region Members 'Services' :: assetsService, locationsService, company

  /// Serviço de recursos
  late IAssetsService assetsService;

  /// Serviço de localizações
  late IService<Location> locationsService;

  /// Empresas
  @computed
  Company get company {
    return this.assetsService.company;
  }

  // #endregion

  // #region Members 'Assets Tree' :: assetsTree

  /// Árvore
  @observable
  late AssetsTree assetsTree;

  // #endregion

  // #region Members 'Assets' :: assets, onLoad(), refresh

  /// Empresas
  @observable
  List<Asset> assets = <Asset>[];

  /// Ao carregar
  @action
  Future<void> onLoad() async {
    try {
      this.setIsLoading(true);

      this.assets = await this.assetsService.getAll();
      this.locations = await this.locationsService.getAll();

      await this.refresh();

      this.setIsLoading(false);
    } catch (exception) {
      throw Exception('Fail in onLoad(): $exception');
    }
  }

  /// Atualizar
  @action
  Future<void> refresh() async {
    try {
      this.setIsLoading(true);

      List<AssetFilter> filters = this.selectedCustomFilters.toList();
      if (this.textSearchFilter.textSearch.isNotEmpty) {
        filters.add(this.textSearchFilter);
      }

      this.assetsTree = AssetsTree(
        locations: this.locations,
        assets: this.assets,
        filters: filters,
      );
      assetsTree.build().then((value) {
        this.setIsLoading(false);
      });
    } catch (exception) {
      throw Exception('Fail in refresh(): $exception');
    }
  }

  // #endregion

  // #region Members 'Locations' :: locations

  /// Localizações
  @observable
  List<Location> locations = <Location>[];

  // #endregion

  // #region Members 'State' :: isLoading, setIsLoading

  @observable
  bool isLoading = true;

  /// Definir carregando
  @action
  Future<void> setIsLoading(bool isLoading) async {
    try {
      this.isLoading = isLoading;
    } catch (exception) {
      throw Exception('Fail in setIsLoading(): $exception');
    }
  }

  // #endregion

  // #region Members 'Custom Filters' :: customFilters, selectedCustomFilters, selectCustomFilter(), hasFilters

  /// Filtros customizados
  List<AssetFilter> get customFilters {
    if (this._filters == null) {
      this._filters = <AssetFilter>[];
      this._filters!.add(EnergySensorTypeFilter());
      this._filters!.add(CriticalAssetStateFilter());
    }

    return this._filters!;
  }

  List<AssetFilter>? _filters;

  /// Filtros selecionados
  @observable
  List<AssetFilter> selectedCustomFilters = <AssetFilter>[];

  /// Selecionar filtro
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
  @computed
  bool get hasFilters =>
      this.selectedCustomFilters.isNotEmpty || this.textSearchFilter.hasFilter;

  // #endregion

  // #region Members 'Text Filter' :: textSearchFilter, onTextSearchFilterChanged()

  /// Filtro de texto
  @observable
  TextSearchFilter textSearchFilter = TextSearchFilter();

  /// Ao buscar pelo filtro de texto
  @action
  Future<void> onTextSearchFilterChanged(String value) async {
    try {
      this.textSearchFilter = TextSearchFilter(textSearch: value);
      this.refresh();
    } catch (exception) {
      throw Exception('Fail in onTextSearchFilterChanged(): $exception');
    }
  }

  // #endregion
}
