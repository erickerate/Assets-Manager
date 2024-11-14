import 'package:domain/domain.dart';

/// Modelo para árvore de ativos
class AssetsTree {
  // #region Members 'Tree' :: roots, items, map

  /// Itens raízes
  List<TreeItem> roots = <TreeItem>[];

  /// Todos os itens
  List<TreeItem> allItems = <TreeItem>[];

  /// Mapa
  Map<String, TreeItem> map = <String, TreeItem>{};

  // #endregion
}
