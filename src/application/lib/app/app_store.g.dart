// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on AppStoreBase, Store {
  Computed<bool>? _$isDarkThemeComputed;

  @override
  bool get isDarkTheme =>
      (_$isDarkThemeComputed ??= Computed<bool>(() => super.isDarkTheme,
              name: 'AppStoreBase.isDarkTheme'))
          .value;
  Computed<bool>? _$isLightThemeComputed;

  @override
  bool get isLightTheme =>
      (_$isLightThemeComputed ??= Computed<bool>(() => super.isLightTheme,
              name: 'AppStoreBase.isLightTheme'))
          .value;
  Computed<bool>? _$isAutoThemeComputed;

  @override
  bool get isAutoTheme =>
      (_$isAutoThemeComputed ??= Computed<bool>(() => super.isAutoTheme,
              name: 'AppStoreBase.isAutoTheme'))
          .value;

  late final _$themeModeAtom =
      Atom(name: 'AppStoreBase.themeMode', context: context);

  @override
  base.ThemeMode get themeMode {
    _$themeModeAtom.reportRead();
    return super.themeMode;
  }

  @override
  set themeMode(base.ThemeMode value) {
    _$themeModeAtom.reportWrite(value, super.themeMode, () {
      super.themeMode = value;
    });
  }

  late final _$setThemeModeAsyncAction =
      AsyncAction('AppStoreBase.setThemeMode', context: context);

  @override
  Future<void> setThemeMode(base.ThemeMode themeMode) {
    return _$setThemeModeAsyncAction.run(() => super.setThemeMode(themeMode));
  }

  @override
  String toString() {
    return '''
themeMode: ${themeMode},
isDarkTheme: ${isDarkTheme},
isLightTheme: ${isLightTheme},
isAutoTheme: ${isAutoTheme}
    ''';
  }
}
