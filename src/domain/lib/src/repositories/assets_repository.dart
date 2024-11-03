import 'package:domain/domain.dart';

/// Repositório abstrato para recursos
abstract class IAssetsRepository implements IRepository<Asset> {
  /// Empresa
  late Company company;
}
