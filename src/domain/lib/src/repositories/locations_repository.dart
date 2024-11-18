import 'package:domain/domain.dart';

/// Interface: Repositório abstrato para localizações
abstract class ILocationsRepository implements IRepository<Location> {
  /// Empresa
  late Company company;
}
