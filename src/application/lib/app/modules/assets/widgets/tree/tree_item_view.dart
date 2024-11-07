import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Componente de visualização para item da árvore
class TreeItemView extends StatefulWidget {
  // #region Constructors

  /// Componente de visualização para item da árvore
  const TreeItemView({
    super.key,
    required this.treeItem,
  });

  // #endregion

  // #region Members 'Parameters' :: treeItem

  /// Item da árvore
  final TreeItem treeItem;

  // #endregion

  @override
  State<TreeItemView> createState() => _TreeItemViewState();
}

class _TreeItemViewState extends State<TreeItemView> {
  // #region Members 'State' :: childrenExpanded

  /// Filhos expandidos?
  bool get childrenExpanded {
    if (this.controller.hasFilters) return true;

    return this._childrenExpanded;
  }

  set childrenExpanded(bool value) {
    this._childrenExpanded = value;
  }

  bool _childrenExpanded = false;

  // #endregion

  // #region Members 'Store' :: controller

  /// Controlador
  final controller = Modular.get<IAssetsStore>();

  // #endregion

  // #region Members 'Builds' :: build()

  @override
  Widget build(BuildContext context) {
    ComponentTreeItem? componentTreeItem =
        (this.widget.treeItem is ComponentTreeItem)
            ? this.widget.treeItem as ComponentTreeItem
            : null;
    return Column(
      children: [
        // #region Item

        Container(
          height: 28,
          padding: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 26 * (this.widget.treeItem.level - 1),
                ),
              ),

              // #region Expandir filhos

              if (this.widget.treeItem.children.isNotEmpty) ...[
                SizedBox(
                  height: 24,
                  width: 24,
                  child: IconButton(
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      this.childrenExpanded
                          ? Icons.keyboard_arrow_down
                          : Icons.keyboard_arrow_right,
                      color: Colors.black,
                      size: 24,
                    ),
                    onPressed: () {
                      if (this.controller.hasFilters) return;

                      this.setState(() {
                        this.childrenExpanded = !this.childrenExpanded;
                      });
                    },
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 2)),
              ],

              // #endregion

              // #region Ícone

              Container(
                height: 24,
                width: 24,
                padding: const EdgeInsets.only(left: 1.5),
                child: Center(
                  child: Image.asset(
                    "assets/images/${this.widget.treeItem.type}.png",
                    height: 24,
                    width: 24,
                  ),
                ),
              ),

              // #endregion

              // #region Descrição

              const Padding(padding: EdgeInsets.only(left: 6)),

              Flexible(
                child: Text(
                  this.widget.treeItem.description,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              // #endregion

              // #region Tipo Componente / Status

              if (componentTreeItem != null) ...[
                if (componentTreeItem.isEnergySensor) ...[
                  const Padding(padding: EdgeInsets.only(right: 6)),
                  Image.asset(
                    "assets/images/${componentTreeItem.sensorType}.png",
                  ),
                ],
                if (componentTreeItem.isAlert) ...[
                  const Padding(padding: EdgeInsets.only(right: 6)),
                  Image.asset(
                    "assets/images/${componentTreeItem.status}.png",
                  ),
                ],
              ],

              // #endregion
            ],
          ),
        ),

        // #endregion

        // #region Filhos

        if (this.childrenExpanded) ...[
          ...this
              .widget
              .treeItem
              .children
              .map((treeItem) => TreeItemView(treeItem: treeItem)),
        ],

        // #endregion
      ],
    );
  }

  // #endregion
}
