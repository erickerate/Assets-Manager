import 'package:domain/domain.dart';

/// Interface: Repositório abstrato para recursos
abstract class IAssetsRepository implements IRepository<Asset> {
  /// Empresa
  late Company company;
}
