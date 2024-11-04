import 'package:domain/domain.dart';
import 'package:domain/src/models/tree/items/component_tree_item.dart';

/// Filtro de estado para estado crítico
class CriticalAssetStateFilter extends AssetFilter {
  // #region Constructors

  /// Filtro de estado para estado crítico
  CriticalAssetStateFilter({
    super.number = "critical",
    super.description = "Crítico",
  });

  // #endregion

  // #region Members 'Meets' :: meets()

  @override
  bool meets(TreeItem treeItem) {
    try {
      if (treeItem is ComponentTreeItem) {
        return treeItem.status == "alert";
      }

      return false;
    } on Exception catch (exception) {
      throw Exception("Fail in meets(): $exception");
    }
  }

  // #endregion
}
