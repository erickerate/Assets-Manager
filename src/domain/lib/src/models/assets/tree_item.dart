import 'package:domain/domain.dart';

/// Item da árvore
class TreeItem {
  // #region Constructors

  /// Item da árvore
  TreeItem({
    required this.id,
    required this.parentId,
    required this.type,
    required this.description,
    this.iconKey,
  });

  // #endregion

  // #region Members 'Header' :: id, parentId, description, type, iconKey,

  /// Identificador
  final String id;

  /// Identificador pai
  final String? parentId;

  /// Descrição
  final String description;

  /// Tipo
  final String type;

  /// Chave de ícone
  final String? iconKey;

  // #endregion

  // #region Members 'Children' :: children, addChild()

  /// Filhos
  List<TreeItem> children = <TreeItem>[];

  /// Adicionar filho
  void addChild(TreeItem item) {
    this.children.add(item);
  }

  // #endregion

  // #region Members 'Create' :: fromLocation(), fromAsset()

  /// Criar item a partir da localização
  static TreeItem fromLocation(Location location) {
    return TreeItem(
      id: location.id!,
      parentId: location.parentId,
      type: "location",
      description: location.name!,
    );
  }

  /// Criar item a partir do recurso
  static TreeItem fromAsset(Asset asset) {
    return TreeItem(
      id: asset.id!,
      parentId: asset.parentId ?? asset.locationId,
      type: asset.sensorId != null && asset.sensorType != null
          ? "component"
          : "asset",
      description: asset.name!,
      iconKey: asset.status,
    );
  }

  // #endregion
}
