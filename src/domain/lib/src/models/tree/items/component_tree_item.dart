import 'package:domain/domain.dart';

/// Item Componente da árvore
class ComponentTreeItem extends TreeItem {
  // #region Constructors

  /// Item Componente da árvore
  ComponentTreeItem({
    required super.id,
    required super.parentId,
    required super.description,
    required this.status,
    required this.sensorType,
    super.type = "component",
  });

  // #endregion

  // #region Members 'Header' :: status, sensorType, isEnergySensor, isAlert

  /// Status
  final String? status;

  /// Tipo de sensor
  final String? sensorType;

  /// É sensor de energia?
  bool get isEnergySensor =>
      this.sensorType != null && this.sensorType == "energy";

  /// Está em alerta?
  bool get isAlert => this.status == "alert";

  // #endregion
}
