import 'package:domain/domain.dart';

/// Serviço abstrato
abstract class IService<T> {
  /// Repositório
  IRepository<T> get repository;

  /// Obter todos
  Future<List<T>> getAll();
}
