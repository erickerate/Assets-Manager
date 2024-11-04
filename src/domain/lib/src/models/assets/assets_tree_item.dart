import 'package:domain/domain.dart';

/// Item da árvore de ativos
class AssetsTreeItem {
  // #region Constructors

  /// Item da árvore
  AssetsTreeItem({
    required this.id,
    required this.parentId,
    required this.type,
    required this.description,
    this.stateIconKey,
  });

  // #endregion

  // #region Members 'Header' :: id, parentId, description, type, iconKey, level

  /// Identificador
  final String id;

  /// Identificador pai
  final String? parentId;

  /// Descrição
  final String description;

  /// Tipo
  final String type;

  /// Chave de ícone
  final String? stateIconKey;

  /// Nível
  int get level {
    if (this.parent != null) {
      return this.parent!.level + 1;
    }

    return 1;
  }

  // #endregion

  // #region Members 'Navigations' :: parent

  /// Pai
  AssetsTreeItem? parent;

  // #endregion

  // #region Members 'Children' :: children, addChild()

  /// Filhos
  List<AssetsTreeItem> children = <AssetsTreeItem>[];

  /// Adicionar filho
  void addChild(AssetsTreeItem item) {
    this.children.add(item);
  }

  // #endregion

  // #region Members 'Create' :: fromLocation(), fromAsset()

  /// Criar item a partir da localização
  static AssetsTreeItem fromLocation(Location location) {
    return AssetsTreeItem(
      id: location.id!,
      parentId: location.parentId,
      type: "location",
      description: location.name!,
    );
  }

  /// Criar item a partir do recurso
  static AssetsTreeItem fromAsset(Asset asset) {
    return AssetsTreeItem(
      id: asset.id!,
      parentId: asset.parentId ?? asset.locationId,
      type: asset.sensorId != null && asset.sensorType != null
          ? "component"
          : "asset",
      description: asset.name!,
      stateIconKey: asset.status,
    );
  }

  // #endregion
}
