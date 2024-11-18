import 'package:application/app/themes/adapters/theme_mode_adapter.dart';
import 'package:domain/domain.dart' as base;
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'app_store.g.dart';

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store implements base.IAppStore {
  // #region Constructors

  AppStoreBase() {
    this.initialize();
  }

  // #endregion

  // #region Members 'Initialize' :: initialize(), _initializeThemeMode()

  /// Inicializar
  @override
  Future<void> initialize() async {
    try {
      this.preferencesProvider = Modular.get<base.IPreferencesProvider>();
      await this.preferencesProvider.initialize();

      await this._initializeThemeMode();
    } on Exception catch (exception) {
      throw Exception("Fail in initialize(): $exception");
    }
  }

  /// Inicializar tema
  Future<void> _initializeThemeMode() async {
    try {
      String? stringValue = await this.preferencesProvider.get("themeMode");
      this.themeMode = ThemeModeAdapter.fromStringValue(stringValue);
    } on Exception catch (exception) {
      throw Exception("Fail in initialize(): $exception");
    }
  }

  // #endregion

  // #region Members 'Preferences' :: preferencesProvider

  /// Provedor de preferências
  @override
  late base.IPreferencesProvider preferencesProvider;

  // #endregion

  // #region Members 'Theme' :: themeMode, isDarkTheme, isLightTheme, isAutoTheme, setThemeMode()

  /// Mode
  @override
  @observable
  base.ThemeMode themeMode = base.ThemeMode.system;

  /// É tema dark?
  @override
  @computed
  bool get isDarkTheme => this.themeMode == base.ThemeMode.dark;

  /// É tema claro?
  @override
  @computed
  bool get isLightTheme => this.themeMode == base.ThemeMode.light;

  /// É tema automático?
  @override
  @computed
  bool get isAutoTheme => this.themeMode == base.ThemeMode.system;

  /// Definir tema
  @override
  @action
  Future<void> setThemeMode(base.ThemeMode themeMode) async {
    try {
      this.themeMode = themeMode;

      await this.preferencesProvider.set("themeMode", this.themeMode.name);
    } on Exception catch (exception) {
      throw Exception("Fail in setThemeMode(): $exception");
    }
  }

  // #endregion
}
