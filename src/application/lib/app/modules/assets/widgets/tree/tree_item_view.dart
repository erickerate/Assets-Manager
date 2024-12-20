import 'package:application/app/resources/object_image.dart';
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
    required this.treeItemStore,
  });

  // #endregion

  // #region Members 'Parameters' :: treeItemId

  /// Id
  final ITreeItemStore treeItemStore;

  // #endregion

  @override
  State<TreeItemView> createState() => _TreeItemViewState();
}

class _TreeItemViewState extends State<TreeItemView> {
  // #region Members 'Store' :: assetsStore

  /// Controlador
  final assetsStore = Modular.get<IAssetsStore>();

  // #endregion

  // #region Members 'Builds' :: build()

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        Color lineColor = Theme.of(context).colorScheme.outline;
        ITreeItemStore treeItemStore = this.widget.treeItemStore;
        TreeItem treeItem = treeItemStore.treeItem;
        bool expanded = treeItemStore.expanded;
        bool isFixedExpanded = treeItemStore.isFixedExpanded;

        ComponentTreeItem? componentTreeItem =
            (treeItem is ComponentTreeItem) ? treeItem : null;
        TreeItemWithStatus? treeItemWithStatus =
            (treeItem is TreeItemWithStatus) ? treeItem : null;

        return Container(
          padding: EdgeInsets.zero,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 28,
                padding: EdgeInsets.zero,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // #region Ligações

                    ...List.generate(treeItem.level - 1, (index) {
                      bool isFirstLevel = index == 0;
                      bool isLastLevel = index == treeItem.level - 2;
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

                    if (treeItem.children.isNotEmpty) ...[
                      Container(
                        height: 24,
                        width: 24,
                        margin: EdgeInsets.only(
                          left: treeItem.isRoot ? 0 : 5,
                        ),
                        child: IconButton(
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                          icon: Icon(
                            expanded
                                ? Icons.keyboard_arrow_down
                                : Icons.keyboard_arrow_right,
                            color: isFixedExpanded
                                ? Theme.of(context).colorScheme.outline
                                : Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                            size: 24,
                          ),
                          onPressed: isFixedExpanded
                              ? null
                              : () {
                                  treeItemStore.setExpanded(
                                    !treeItemStore.expanded,
                                    setChildrenVisibility: true,
                                  );
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
                        left: treeItem.hasChildren || treeItem.isRoot ? 1.5 : 7,
                      ),
                      child: Center(
                        child: ObjectImage.getByKey(
                          "${treeItem.type}.png",
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
                        treeItem.description,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 14,
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),

                    // #endregion

                    // #region Tipo Componente

                    if (componentTreeItem != null &&
                        componentTreeItem.isEnergySensor) ...[
                      const Padding(padding: EdgeInsets.only(right: 6)),
                      ObjectImage.getByKey(
                        "${componentTreeItem.sensorType}.png",
                      ),
                    ],

                    // #endregion

                    // #region Status

                    if (treeItemWithStatus != null &&
                        treeItemWithStatus.isAlert) ...[
                      const Padding(padding: EdgeInsets.only(right: 6)),
                      ObjectImage.getByKey(
                        "${treeItemWithStatus.status}.png",
                      ),
                    ]

                    // #endregion
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // #endregion
}
