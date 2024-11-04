import 'package:domain/domain.dart';
import 'package:domain/src/models/tree/items/component_tree_item.dart';

/// Filtro para tipo do sensor de energia
class EnergySensorTypeFilter extends AssetFilter {
  // #region Constructors

  /// Filtro para tipo do sensor de energia
  EnergySensorTypeFilter({
    super.number = "energySensor",
    super.description = "Sensor de energia",
  });

  // #endregion

  // #region Members 'Meets' :: meets()

  @override
  bool meets(TreeItem treeItem) {
    try {
      if (treeItem is ComponentTreeItem) {
        return treeItem.isEnergySensor;
      }

      return false;
    } on Exception catch (exception) {
      throw Exception("Fail in meets(): $exception");
    }
  }

  // #endregion
}
