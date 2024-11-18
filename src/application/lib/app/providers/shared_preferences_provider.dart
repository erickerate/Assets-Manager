import 'package:domain/domain.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Provedor de preferências com SharedPreferences
class SharedPreferencesProvider implements IPreferencesProvider {
  // #region Members 'Preferences' :: initialize(), get(), exists(), set()

  /// Preferências
  late SharedPreferences _preferences;

  @override
  Future<void> initialize() async {
    try {
      this._preferences = await SharedPreferences.getInstance();
    } on Exception catch (exception) {
      throw Exception("Fail in initialize(): $exception");
    }
  }

  @override
  Future<String?> get(String key) async {
    try {
      return this._preferences.getString(key);
    } on Exception catch (exception) {
      throw Exception("Fail in get(): $exception");
    }
  }

  @override
  Future<bool> exists(String key) async {
    try {
      return this._preferences.containsKey(key);
    } on Exception catch (exception) {
      throw Exception("Fail in exists(): $exception");
    }
  }

  @override
  Future<bool> set(String key, String value) async {
    try {
      return await this._preferences.setString(key, value);
    } on Exception catch (exception) {
      throw Exception("Fail in set(): $exception");
    }
  }

  // #endregion
}
