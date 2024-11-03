import 'package:domain/domain.dart';

/// Contexto gerenciador de ativos
class AssetsManagerContext {
  // #region Members 'Collections' :: companies, locations, assets

  /// Empresas
  List<Company> companies = <Company>[];

  /// Localizações
  List<Location> locations = <Location>[];

  /// Recursos
  List<Asset> assets = <Asset>[];

  // #endregion
}
