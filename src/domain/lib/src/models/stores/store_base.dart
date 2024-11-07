/// Loja base
abstract class StoreBase {
  // #region Members 'Loading' :: isLoading, dispatchIsLoading

  /// Está carregando?
  bool isLoading = true;

  /// Despachar carregando
  Future<void> dispatchIsLoading(bool isLoading) async {
    try {
      this.isLoading = isLoading;
    } catch (exception) {
      throw Exception('Fail in dispatchIsLoading(): $exception');
    }
  }

  // #endregion
}
