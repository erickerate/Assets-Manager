import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

/// Componente de visualização para recurso
class AssetListItemView extends StatefulWidget {
  // #region Constructors

  /// Componente de visualização para recurso
  const AssetListItemView({
    super.key,
    required this.asset,
  });

  // #endregion

  // #region Members 'Parameters' :: asset

  /// Recurso
  final Asset asset;

  // #endregion

  @override
  State<AssetListItemView> createState() => _AssetListItemViewState();
}

class _AssetListItemViewState extends State<AssetListItemView> {
  // #region Members 'Builds' :: build()

  @override
  Widget build(BuildContext context) {
    return Text(this.widget.asset.name ?? "");
  }

  // #endregion
}
