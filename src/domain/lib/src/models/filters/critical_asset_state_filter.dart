import 'package:domain/domain.dart';
import 'package:domain/src/models/tree/items/tree_item_with_status.dart';

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
      if (treeItem is TreeItemWithStatus) {
        return treeItem.isAlert;
      }

      return false;
    } on Exception catch (exception) {
      throw Exception("Fail in meets(): $exception");
    }
  }

  // #endregion
}
