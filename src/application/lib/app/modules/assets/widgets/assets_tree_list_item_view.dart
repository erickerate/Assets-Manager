import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

/// Componente de visualização para item da árvore
class AssetsTreeListItemView extends StatefulWidget {
  // #region Constructors

  /// Componente de visualização para item da árvore
  const AssetsTreeListItemView({
    super.key,
    required this.treeItem,
  });

  // #endregion

  // #region Members 'Parameters' :: treeItem

  /// Item da árvore
  final AssetsTreeItem treeItem;

  // #endregion

  @override
  State<AssetsTreeListItemView> createState() => _AssetsTreeListItemViewState();
}

class _AssetsTreeListItemViewState extends State<AssetsTreeListItemView> {
  // #region Members 'State' :: childrenExpanded

  /// Filhos expandidos?
  bool childrenExpanded = false;

  // #endregion

  // #region Members 'Builds' :: build()

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // #region Item

        Container(
          height: 28,
          padding: const EdgeInsets.symmetric(vertical: 3),
          // color: Colors.blue,
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
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),

              // #endregion

              // #region Estado

              if (this.widget.treeItem.stateIconKey != null) ...[
                const Padding(padding: EdgeInsets.only(right: 6)),
                Image.asset(
                  "assets/images/${this.widget.treeItem.stateIconKey}.png",
                ),
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
              .map((treeItem) => AssetsTreeListItemView(treeItem: treeItem)),
        ],
        // #endregion
      ],
    );
  }

  // #endregion
}
