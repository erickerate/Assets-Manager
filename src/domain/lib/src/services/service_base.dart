import 'package:domain/domain.dart';

/// Serviço abstrato
abstract class ServiceBase<T> {
  /// Repositório
  IRepository<T> get repository;

  /// Obter todos
  Future<List<T>> getAll();
}
