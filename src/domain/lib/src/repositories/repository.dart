/// Repositório abstrato
abstract class IRepository<T> {
  /// Obter todos
  Future<List<T>> getAll();
}
