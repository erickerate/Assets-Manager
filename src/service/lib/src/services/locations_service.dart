import 'package:domain/domain.dart';

/// Serviço para localizações
class LocationsService implements ServiceBase<Location> {
  // #region Constructors

  /// Serviço para localizações
  LocationsService({required this.repository});

  // #endregion

  // #region Members 'IRepository' :: repository

  /// Repositório
  @override
  IRepository<Location> repository;

  // #endregion

  // #region Members 'Service' :: getAll()

  /// Obter todas localizações
  @override
  Future<List<Location>> getAll() async {
    try {
      List<Location> locations = await this.repository.getAll();
      return locations;
    } on Exception catch (exception) {
      throw Exception("Fail in getAll(): $exception");
    }
  }

  // #endregion
}
