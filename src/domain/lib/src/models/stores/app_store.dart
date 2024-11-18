import 'package:domain/domain.dart';

/// Loja do app
abstract class IAppStore {
  // #region Members 'Initialize' :: initialize()

  /// Inicializar
  Future<void> initialize();

  // #endregion

  // #region Members 'Preferences' :: preferencesProvider

  /// Provedor de preferências
  late IPreferencesProvider preferencesProvider;

  // #endregion

  // #region Members 'Theme' :: themeMode, isDarkTheme, isLightTheme, isAutoTheme, setThemeMode()

  /// Modo do tema
  late ThemeMode themeMode;

  /// É tema dark?
  bool get isDarkTheme;

  /// É tema claro?
  bool get isLightTheme;

  /// É tema automático?
  bool get isAutoTheme;

  /// Definir modo do tema
  Future<void> setThemeMode(ThemeMode themeMode);

  // #endregion
}
