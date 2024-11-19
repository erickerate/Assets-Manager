import 'package:flutter/material.dart';

/// Imagens
abstract class ObjectImage {
  // #region Members 'Images' :: _cache

  /// Imagens
  static final Map<String, Image> _cache = <String, Image>{};

  // #endregion

  // #region Members 'Get' :: getByKey()

  /// Obter imagem pela chave
  static Image getByKey(String key, {double? height, double? width}) {
    try {
      if (!_cache.containsKey(key)) {
        _cache[key] = Image.asset(
          "assets/images/$key",
          height: height,
          width: width,
        );
      }

      return _cache[key]!;
    } on Exception catch (exception) {
      throw Exception("Fail in getByKey(): $exception");
    }
  }

  // #endregion
}
