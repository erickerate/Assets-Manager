import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
    Color lineColor = const Color(0xFFD8DFE6);
    return Observer(
      builder: (context) {
        bool treeItemIsExpanded =
            this.controller.expandedTreeItems.contains(this.widget.treeItem);
        return Container(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              // #region Item

              Container(
                height: 28,
                padding: EdgeInsets.zero,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // #region Ligações

                    ...List.generate(this.widget.treeItem.level - 1, (index) {
                      bool isFirstLevel = index == 0;
                      bool isLastLevel =
                          index == this.widget.treeItem.level - 2;
                      bool hasPointer = isLastLevel;
                      double paddingLeft = isFirstLevel ? 11 : 25;
                      return Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          // #region Linha vertical
                          Container(
                            padding: EdgeInsets.zero,
                            margin: EdgeInsets.only(left: paddingLeft),
                            width: 1,
                            height: double.infinity,
                            color: lineColor,
                          ),
                          // #endregion
                          // #region Linha horizontal
                          Visibility(
                            visible: hasPointer,
                            child: Container(
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.only(left: paddingLeft),
                              width: hasPointer ? 10 : 1,
                              height: 14,
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    width: 1,
                                    color: lineColor,
                                  ),
                                  bottom: BorderSide(
                                    width: 1,
                                    color: lineColor,
                                  ),
                                ),
                              ),
                            ),
                          )
                          // #endregion
                        ],
                      );
                    }),

                    // #endregion

                    // #region Expandir filhos

                    if (this.widget.treeItem.children.isNotEmpty) ...[
                      Container(
                        height: 24,
                        width: 24,
                        margin: EdgeInsets.only(
                          left: this.widget.treeItem.isFirstLevel ? 0 : 5,
                        ),
                        child: IconButton(
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            treeItemIsExpanded
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_right,
                            color: Colors.black,
                            size: 24,
                          ),
                          onPressed: () {
                            if (this.controller.hasFilters) return;

                            this
                                .controller
                                .toggleExpandedItem(this.widget.treeItem);
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
                      margin: EdgeInsets.only(
                        left: this.widget.treeItem.hasChildren ||
                                this.widget.treeItem.isFirstLevel
                            ? 1.5
                            : 7,
                      ),
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

              if (treeItemIsExpanded) ...[
                ...this
                    .widget
                    .treeItem
                    .children
                    .map((treeItem) => TreeItemView(treeItem: treeItem)),
              ],

              // #endregion
            ],
          ),
        );
      },
    );
  }

  // #endregion
}
