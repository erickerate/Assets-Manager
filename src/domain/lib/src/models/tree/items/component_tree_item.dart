import 'tree_item_with_status.dart';

/// Item Componente da árvore
class ComponentTreeItem extends TreeItemWithStatus {
  // #region Constructors

  /// Item Componente da árvore
  ComponentTreeItem({
    required super.id,
    required super.parentId,
    required super.description,
    required super.status,
    required this.sensorType,
    super.type = "component",
  });

  // #endregion

  // #region Members 'Header' :: sensorType, isEnergySensor

  /// Tipo de sensor
  final String? sensorType;

  /// É sensor de energia?
  bool get isEnergySensor =>
      this.sensorType != null && this.sensorType == "energy";

  // #endregion
}
