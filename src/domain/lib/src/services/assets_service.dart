import 'package:domain/domain.dart';

/// Serviço abstrato para recursos
abstract class IAssetsService implements IService<Asset> {
  /// Empresa
  Company get company;
}
