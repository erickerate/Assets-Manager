part of '../app_view.dart';

/// Esquema de cores claras
const _lightColorScheme = ColorScheme(
  brightness: Brightness.light,

  // #region Base

  /// Primária
  primary: Color(0xFF17192D),

  /// Contraste da primaria
  onPrimary: Colors.white,

  /// Contraste da primária desabilitada
  inversePrimary: Color(0xFFD3D3D3),

  /// Cor do container
  primaryContainer: Colors.white,

  /// Contraste do container
  onPrimaryContainer: Colors.black,

  /// Secundária
  secondary: Color(0XFF2a57dd),

  /// Contraste da secundária
  onSecondary: Colors.white,

  /// Contraste da secundária
  onSecondaryContainer: Color(0xFF77818C),

  /// Superfícies (Inputs)
  surface: Color(0xFFEAEFF3),

  /// Ícones e textos
  onSurface: Color(0XFF8E98A3),

  /// Bordas de superfícies
  outline: Color(0xFFD8DFE6),

  /// Sombra
  shadow: Color(0xFFEAEEF2),

  /// Terciária
  tertiary: Color(0xFF77818C),

  // #endregion

  onTertiary: Color(0xFF492532),
  tertiaryContainer: Color(0xFF633B48),
  onTertiaryContainer: Color(0xFFFFD8E4),
  error: Color(0xFFF2B8B5),
  onError: Color(0xFF601410),
  errorContainer: Color(0xFF8C1D18),
  onErrorContainer: Color(0xFFF9DEDC),
  surfaceContainerHighest: Color(0xFF49454F),
  onSurfaceVariant: Color(0xFFCAC4D0),
  inverseSurface: Color(0xFFE6E1E5),
  onInverseSurface: Color(0xFF313033),
  surfaceTint: Color(0xFFD0BCFF),
);

/// Esquema de cores escuras
const _darkColorScheme = ColorScheme(
  brightness: Brightness.dark,

  // #region Base

  /// Primária
  primary: Color(0xFF17192D),

  /// Contraste da primária
  onPrimary: Colors.white,

  /// Contraste da primária desabilitada
  inversePrimary: Color(0xFFD3D3D3),

  /// Cor do container sobre a primária
  primaryContainer: Color(0xFF1D1D1B),

  /// Contraste do container sobre a primária
  onPrimaryContainer: Color(0xFFFFFFFF),

  /// Secundária
  secondary: Color(0XFF2a57dd),

  /// Contraste da secundária
  onSecondary: Colors.white,

  /// Contraste da secundária
  onSecondaryContainer: Color(0xFF77818C),

  /// Bordas de superfícies
  outline: Color(0XFF2b2b2b),

  /// Ícones e textos
  onSurface: Color(0xFFcccccc),

  /// Sombra
  shadow: Color(0XFF2b2b2b),

  // #endregion

  tertiary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFF4A4458),
  onTertiary: Color(0xFF492532),
  tertiaryContainer: Color(0xFF633B48),
  onTertiaryContainer: Color(0xFFFFD8E4),
  error: Color(0xFFF2B8B5),
  onError: Color(0xFF601410),
  errorContainer: Color(0xFF8C1D18),
  onErrorContainer: Color(0xFFF9DEDC),
  surface: Color(0xFF1C1B1F),
  surfaceContainerHighest: Color(0xFF49454F),
  onSurfaceVariant: Color(0xFFCAC4D0),
  inverseSurface: Color(0xFFE6E1E5),
  onInverseSurface: Color(0xFF313033),

  surfaceTint: Color(0xFFD0BCFF),
);
