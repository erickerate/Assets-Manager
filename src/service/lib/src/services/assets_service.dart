import 'package:domain/domain.dart';

/// Serviço para recursos
class AssetsService implements IService<Asset> {
  // #region Constructors

  /// Serviço para recursos
  AssetsService({required this.repository});

  // #endregion

  // #region Members 'IRepository' :: repository

  /// Repositório
  @override
  IRepository<Asset> repository;

  // #endregion

  // #region Members 'Service' :: getAll()

  /// Obter todos recursos
  @override
  Future<List<Asset>> getAll() async {
    try {
      List<Asset> assets = await this.repository.getAll();
      return assets;
    } on Exception catch (exception) {
      throw Exception("Fail in getAll(): $exception");
    }
  }

  // #endregion
}
