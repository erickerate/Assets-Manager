import 'package:domain/domain.dart';

/// Serviço para localizações
class LocationsService implements LocationsServiceBase {
  // #region Constructors

  /// Serviço para localizações
  LocationsService({required this.repository});

  // #endregion

  // #region Members 'IRepository' :: repository

  /// Repositório
  @override
  ILocationsRepository repository;

  // #endregion

  // #region Members 'Service' :: getAll()

  @override
  Company get company {
    return this.repository.company;
  }

  @override
  set company(Company value) {
    this.repository.company = value;
  }

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
