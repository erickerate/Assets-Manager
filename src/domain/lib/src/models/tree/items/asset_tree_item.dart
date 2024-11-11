import 'package:domain/src/models/tree/items/tree_item_with_status.dart';

/// Item Ativo da árvore
class AssetTreeItem extends TreeItemWithStatus {
  // #region Constructors

  /// Item Ativo da árvore
  AssetTreeItem({
    required super.id,
    required super.parentId,
    required super.description,
    required super.status,
    super.type = "asset",
  });

  // #endregion
}
