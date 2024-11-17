import 'package:domain/domain.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'tree_item_store.g.dart';

class TreeItemStore = TreeItemStoreBase with _$TreeItemStore;

abstract class TreeItemStoreBase with Store implements ITreeItemStore {
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
    if (this.isFixedExpanded) {
      return;
    }

    this.expanded = expanded;
    if (setChildrenVisibility) {
      if (this.expanded) {
        for (TreeItem treeItem in this.treeItem.children) {
          ITreeItemStore treeItemStore =
              this.assetsStore.treeItemStores[treeItem.id]!;

          treeItemStore.setExpanded(false);
          treeItemStore.setVisible(true);
        }
      } else {
        List<ITreeItemStore> expandedDescendants = this
            .assetsStore
            .treeItemStores
            .values
            .where((treeItemStore) =>
                treeItemStore.visible &&
                treeItemStore.treeItem.ascendants.contains(this.treeItem))
            .toList();
        for (ITreeItemStore expandedDescendant in expandedDescendants) {
          expandedDescendant.setExpanded(false);
          expandedDescendant.setVisible(false);
        }
      }
    }
  }

  /// Está fixo em modo expandido?
  @override
  @observable
  bool isFixedExpanded = false;

  /// Definir Está fixo em modo expandido?
  @override
  @action
  void setIsFixedExpanded(bool isFixedExpanded) {
    if (this.isFixedExpanded == isFixedExpanded) return;

    this.isFixedExpanded = isFixedExpanded;
    this.treeItem.isFixedExpanded = this.isFixedExpanded;
  }

  @override
  String toString() {
    return "${this.visible} - ${this.treeItem.description}";
  }

  // #endregion
}
