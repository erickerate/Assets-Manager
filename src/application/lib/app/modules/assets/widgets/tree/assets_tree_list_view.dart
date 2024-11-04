import 'package:application/app/modules/assets/assets_store.dart';
import 'package:application/app/modules/assets/widgets/tree/assets_tree_list_item_view.dart';
import 'package:application/app/widgets/skeleton_loader_view.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

/// Componente de visualização para árvore de ativos
class TreeAssetsListView extends StatefulWidget {
  const TreeAssetsListView({super.key});

  @override
  State<TreeAssetsListView> createState() => _TreeAssetsListViewState();
}

class _TreeAssetsListViewState extends State<TreeAssetsListView> {
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
                itemCount: this.controller.assetsTree.treeItems.length,
                separatorBuilder: (context, index) {
                  return const Padding(padding: EdgeInsets.only(bottom: 4));
                },
                itemBuilder: (context, index) {
                  AssetsTreeItem asset =
                      this.controller.assetsTree.treeItems[index];
                  return AssetsTreeListItemView(
                    treeItem: asset,
                  );
                },
              )
            : const SkeletonLoaderView(),
      );
    });
  }

  // #endregion
}
