// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_item_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$TreeItemStore on TreeItemStoreBase, Store {
  late final _$treeItemAtom =
      Atom(name: '_TreeItemStoreBase.treeItem', context: context);

  @override
  TreeItem get treeItem {
    _$treeItemAtom.reportRead();
    return super.treeItem;
  }

  bool _treeItemIsInitialized = false;

  @override
  set treeItem(TreeItem value) {
    _$treeItemAtom
        .reportWrite(value, _treeItemIsInitialized ? super.treeItem : null, () {
      super.treeItem = value;
      _treeItemIsInitialized = true;
    });
  }

  late final _$visibleAtom =
      Atom(name: '_TreeItemStoreBase.visible', context: context);

  @override
  bool get visible {
    _$visibleAtom.reportRead();
    return super.visible;
  }

  @override
  set visible(bool value) {
    _$visibleAtom.reportWrite(value, super.visible, () {
      super.visible = value;
    });
  }

  late final _$expandedAtom =
      Atom(name: '_TreeItemStoreBase.expanded', context: context);

  @override
  bool get expanded {
    _$expandedAtom.reportRead();
    return super.expanded;
  }

  @override
  set expanded(bool value) {
    _$expandedAtom.reportWrite(value, super.expanded, () {
      super.expanded = value;
    });
  }

  late final _$canToggleExpandAtom =
      Atom(name: '_TreeItemStoreBase.canToggleExpand', context: context);

  @override
  bool get canToggleExpand {
    _$canToggleExpandAtom.reportRead();
    return super.canToggleExpand;
  }

  @override
  set canToggleExpand(bool value) {
    _$canToggleExpandAtom.reportWrite(value, super.canToggleExpand, () {
      super.canToggleExpand = value;
    });
  }

  late final _$_TreeItemStoreBaseActionController =
      ActionController(name: '_TreeItemStoreBase', context: context);

  @override
  void setVisible(bool visible) {
    final _$actionInfo = _$_TreeItemStoreBaseActionController.startAction(
        name: '_TreeItemStoreBase.setVisible');
    try {
      return super.setVisible(visible);
    } finally {
      _$_TreeItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setExpanded(bool expanded, {bool setChildrenVisibility = false}) {
    final _$actionInfo = _$_TreeItemStoreBaseActionController.startAction(
        name: '_TreeItemStoreBase.setExpanded');
    try {
      return super
          .setExpanded(expanded, setChildrenVisibility: setChildrenVisibility);
    } finally {
      _$_TreeItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCanToggleExpand(bool canToggleExpand) {
    final _$actionInfo = _$_TreeItemStoreBaseActionController.startAction(
        name: '_TreeItemStoreBase.setCanToggleExpand');
    try {
      return super.setCanToggleExpand(canToggleExpand);
    } finally {
      _$_TreeItemStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
treeItem: ${treeItem},
visible: ${visible},
expanded: ${expanded},
canToggleExpand: ${canToggleExpand}
    ''';
  }
}
