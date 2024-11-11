import 'package:domain/domain.dart';

/// Item com status
abstract class TreeItemWithStatus extends TreeItem {
  // #region Constructors

  /// Item com status
  TreeItemWithStatus({
    required super.id,
    required super.parentId,
    required super.description,
    required super.type,
    required this.status,
  });

  // #endregion

  // #region Members 'Status' :: status, isAlert

  /// Status
  final String? status;

  /// Está em alerta?
  bool get isAlert => this.status == "alert";

  // #endregion
}
