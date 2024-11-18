import 'package:application/app/providers/shared_preferences_provider.dart';
import 'package:domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late IPreferencesProvider provider;
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    provider = SharedPreferencesProvider();
    await provider.initialize();
  });

  group("Preferences :: ", () {
    test("Must save/get a preference", () async {
      // #region Arrange

      String key = "Tractian";
      String value =
          "Where others hear noise, we find patterns — Fourier is the key to this symphony.";

      // #endregion

      // #region Act

      bool success = await provider.set(key, value);
      String? addedValue = await provider.get(key);
      bool exists = await provider.exists(key);

      // #endregion

      // #region Assert

      expect(success, true);
      expect(exists, true);
      expect(addedValue, isNotNull);
      expect(addedValue, isA<String>());
      expect(addedValue, value);

      // #endregion
    });
  });
}
