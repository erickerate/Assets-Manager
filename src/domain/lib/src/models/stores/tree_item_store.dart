import 'package:domain/domain.dart';

/// Interface loja para item da árvore
abstract class ITreeItemStore {
  // #region Members 'TreeItem' :: treeItem, visible, setVisible(), expanded, setExpanded()

  /// Item
  late TreeItem treeItem;

  /// Visível?
  bool visible = true;

  /// Definir visibilidade
  void setVisible(bool visible);

  /// Expandido?
  bool expanded = false;

  /// Definir expandido
  void setExpanded(bool expanded, {bool setChildrenVisibility = false});

  /// Pode alternar expandido?
  bool canToggleExpand = true;

  /// Definir correspondência de filtro
  void setCanToggleExpand(bool canToggleExpanded);

  // #endregion
}
