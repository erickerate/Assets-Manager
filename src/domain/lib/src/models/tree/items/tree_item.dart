import 'package:domain/domain.dart';

/// Item da árvore
class TreeItem {
  // #region Constructors

  /// Item da árvore
  TreeItem({
    required this.id,
    required this.parentId,
    required this.description,
    required this.type,
  });

  // #endregion

  // #region Members 'Header' :: id, parentId, description, type, level

  /// Identificador
  final String id;

  /// Identificador pai
  final String? parentId;

  /// Descrição
  final String description;

  /// Tipo
  final String type;

  /// Nível
  int get level {
    if (this.parent != null) {
      return this.parent!.level + 1;
    }

    return 1;
  }

  /// É primeiro nível?
  bool get isFirstLevel {
    return this.level == 1;
  }

  @override
  String toString() {
    return "${this.level} - ${this.description}";
  }

  // #endregion

  // #region Members 'Navigations' :: parent

  /// Pai
  TreeItem? parent;

  // #endregion

  // #region Members 'Children' :: hasChildren, children, addChild()

  /// Possui filhos
  bool get hasChildren => this.children.isNotEmpty;

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
    // Componente
    bool isComponent = asset.sensorId != null;
    if (isComponent) {
      return ComponentTreeItem(
        id: asset.id!,
        parentId: asset.parentId ?? asset.locationId,
        description: asset.name!,
        sensorType: asset.sensorType,
        status: asset.status,
      );
    }

    // Ativo
    return TreeItem(
      id: asset.id!,
      parentId: asset.parentId ?? asset.locationId,
      type: "asset",
      description: asset.name!,
    );
  }

  // #endregion
}
