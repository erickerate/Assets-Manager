import 'package:domain/domain.dart';
import 'package:service/src/providers/shared_preferences_provider.dart';
import 'package:test/test.dart';

void main() {
  late IPreferencesProvider provider;
  setUp(() async {
    provider = SharedPreferencesProvider();
    await provider.initialize();
  });

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
}
