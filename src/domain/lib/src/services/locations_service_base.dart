import 'package:domain/domain.dart';

/// Serviço abstrato para localizações
abstract class LocationsServiceBase extends ServiceBase<Location> {
  // #region Members 'Owner' :: company

  /// Empresa
  late Company company;

  // #endregion
}
