import 'package:domain/domain.dart';

/// Modelo para árvore de ativos
class AssetsTree {
  // #region Members 'Tree' :: roots, allItems, stackItems, map

  /// Pilha (Linearização da árvore)
  List<TreeItem> stackItems = [];

  /// Mapa
  Map<String, TreeItem> map = <String, TreeItem>{};

  // #endregion
}
