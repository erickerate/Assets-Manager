import 'package:application/app/modules/assets/assets_store.dart';
import 'package:application/app/modules/assets/widgets/tree/tree_item_view.dart';
import 'package:application/app/widgets/skeleton_loader_view.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Componente de visualização para árvore de ativos
class TreeItemsView extends StatefulWidget {
  const TreeItemsView({super.key});

  @override
  State<TreeItemsView> createState() => _TreeItemsViewState();
}

class _TreeItemsViewState extends State<TreeItemsView> {
  // #region Members 'Overrides' :: initState()

  @override
  void initState() {
    try {
      super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await this.onRefresh();
      });
    } catch (exception) {
      throw Exception("Fail in initState(): $exception");
    }
  }

  // #endregion

  // #region Members 'Store' :: controller, onRefresh()

  /// Controlador
  final controller = Modular.get<AssetsStore>();

  /// Ao atualizar
  Future<void> onRefresh() async {
    try {
      await this.controller.onLoad();
    } catch (exception) {
      throw Exception("Fail in onRefreshing(): $exception");
    }
  }

  // #endregion

  // #region Members 'Builds' :: build()

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
        child: !this.controller.isLoading
            ? ListView.separated(
                itemCount: this.controller.assetsTree.filteredTreeItems.length,
                separatorBuilder: (context, index) {
                  return const Padding(padding: EdgeInsets.only(bottom: 4));
                },
                itemBuilder: (context, index) {
                  TreeItem treeItem =
                      this.controller.assetsTree.filteredTreeItems[index];
                  return TreeItemView(
                    key: Key(treeItem.id),
                    treeItem: treeItem,
                  );
                },
              )
            : const SkeletonLoaderView(),
      );
    });
  }

  // #endregion
}
