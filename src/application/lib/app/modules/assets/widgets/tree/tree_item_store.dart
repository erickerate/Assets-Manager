import 'package:domain/domain.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'tree_item_store.g.dart';

class TreeItemStore = _TreeItemStoreBase with _$TreeItemStore;

abstract class _TreeItemStoreBase with Store implements ITreeItemStore {
  // #region Members 'Store' :: assetsStore

  /// Controlador
  final assetsStore = Modular.get<IAssetsStore>();

  // #endregion

  // #region Members 'TreeItem' :: treeItem, visible, setVisible(), expanded, setExpanded()

  /// Item
  @override
  @observable
  late TreeItem treeItem;

  /// Visível?
  @override
  @observable
  bool visible = true;

  /// Definir visibilidade
  @override
  @action
  void setVisible(bool visible) {
    if (this.visible == visible) return;
    this.visible = visible;
    this.treeItem.visible = visible;
  }

  /// Expandido?
  @override
  @observable
  bool expanded = false;

  /// Alternar expandido
  @override
  @action
  void setExpanded(bool expanded, {bool setChildrenVisibility = false}) {
    if (!this.canToggleExpand) return;

    this.expanded = expanded;
    if (expanded && setChildrenVisibility) {
      for (TreeItem treeItem in this.treeItem.children) {
        ITreeItemStore treeItemStore =
            this.assetsStore.treeItemStores[treeItem.id]!;
        treeItemStore.setExpanded(false);
        treeItemStore.setVisible(true);
      }
    }
  }

  /// Pode alternar expandido?
  @override
  @observable
  bool canToggleExpand = true;

  /// Definir pode alternar expandido?
  @override
  @action
  void setCanToggleExpand(bool canToggleExpand) {
    this.canToggleExpand = canToggleExpand;
  }

  @override
  String toString() {
    return "${this.visible} - ${this.treeItem.description}";
  }

  // #endregion
}
