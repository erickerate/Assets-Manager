import 'package:domain/domain.dart';

/// Interface loja para item da árvore
abstract class ITreeItemStore {
  // #region Members 'TreeItem' :: treeItem, visible, setVisible(), expanded, setExpanded(), isFixedVisible, setIsFixedVisible()

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

  /// Está fixo em modo expandido?
  bool isFixedExpanded = false;

  /// Definir Está fixo em modo expandido?
  void setIsFixedExpanded(bool isFixedExpanded);

  // #endregion
}
