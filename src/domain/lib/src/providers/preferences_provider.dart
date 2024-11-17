/// Provedor de preferências
abstract class IPreferencesProvider {
  /// Inicializar
  Future<void> initialize();

  /// Obter
  Future<String?> get(String key);

  /// Existe?
  Future<bool> exists(String key);

  /// Definir
  Future<bool> set(String key, String value);
}
