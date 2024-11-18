import 'package:domain/domain.dart' as base;
import 'package:flutter/material.dart';

/// Adaptador tema
abstract class ThemeModeAdapter {
  /// Retorna um tema base a partir de uma string
  static base.ThemeMode fromStringValue(String? stringValue) {
    try {
      switch (stringValue) {
        case "system":
          return base.ThemeMode.system;
        case "light":
          return base.ThemeMode.light;
        case "dark":
          return base.ThemeMode.dark;
      }

      return base.ThemeMode.system;
    } on Exception catch (exception) {
      throw Exception("Fail in fromStringValue(): $exception");
    }
  }

  /// Converte para material theme
  static ThemeMode toMaterialThemeMode(base.ThemeMode themeMode) {
    try {
      ThemeMode materialThemeMode;

      if (themeMode == base.ThemeMode.system) {
        materialThemeMode = ThemeMode.system;
      } else if (themeMode == base.ThemeMode.light) {
        materialThemeMode = ThemeMode.light;
      } else {
        materialThemeMode = ThemeMode.dark;
      }

      return materialThemeMode;
    } on Exception catch (exception) {
      throw Exception("Fail in toMaterialThemeMode(): $exception");
    }
  }
}
