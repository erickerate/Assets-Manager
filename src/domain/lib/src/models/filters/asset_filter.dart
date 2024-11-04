import 'package:domain/domain.dart';

/// Filtro de ativo
abstract class AssetFilter {
  // #region Constructors

  /// Filtro de ativo
  AssetFilter({
    required this.number,
    required this.description,
  });

  // #endregion

  // #region Members 'Primary properties' :: number, description

  /// Número
  late String number;

  /// Descrição
  late String description;

  // #endregion

  // #region Members 'Meets' :: meets()

  /// Item atende ao filtro?
  bool meets(TreeItem treeItem);

  // #endregion
}
