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
    this.service = Modular.get<IAssetsService>();
  }

  // #endregion

  // #region Members 'Service' :: service

  /// Serviço
  late IAssetsService service;

  /// Empresas
  @computed
  Company get company {
    return this.service.company;
  }

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

      this.assets = await this.service.getAll();

      this.setIsLoading(false);
    } catch (exception) {
      throw Exception('Fail in queryAssets(): $exception');
    }
  }

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
