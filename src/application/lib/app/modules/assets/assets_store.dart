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

  // #region Members 'Assets' :: assets, queryAssets()

  /// Empresas
  @observable
  List<Asset> assets = <Asset>[];

  /// Buscar recursos
  @action
  Future<void> queryAssets() async {
    try {
      this.setIsLoading(true);

      this.assets = await this.assetsService.getAll();
      this.locations = await this.locationsService.getAll();

      this.assetsTree = AssetsTree(
        locations: this.locations,
        assets: this.assets,
      );

      this.setIsLoading(false);
    } catch (exception) {
      throw Exception('Fail in queryAssets(): $exception');
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
}