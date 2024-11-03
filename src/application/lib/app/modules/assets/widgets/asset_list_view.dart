import 'package:application/app/modules/assets/assets_store.dart';
import 'package:application/app/modules/assets/widgets/asset_list_item_view.dart';
import 'package:application/app/modules/companies/widgets/company_list_view_skeleton_loader.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AssetListView extends StatefulWidget {
  const AssetListView({super.key});

  @override
  State<AssetListView> createState() => _AssetListViewState();
}

class _AssetListViewState extends State<AssetListView> {
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
      await this.controller.queryAssets();
    } catch (exception) {
      throw Exception("Fail in onRefreshing(): $exception");
    }
  }

  // #endregion

  // #region Members 'Builds' :: build()

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: this.onRefresh,
      child: Observer(builder: (_) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 30),
          child: !this.controller.isLoading
              ? ListView.separated(
                  itemCount: this.controller.assets.length,
                  separatorBuilder: (context, index) {
                    return const Padding(padding: EdgeInsets.only(bottom: 40));
                  },
                  itemBuilder: (context, index) {
                    Asset asset = this.controller.assets[index];
                    return AssetListItemView(
                      asset: asset,
                    );
                  },
                )
              : const CompanyListViewSkeletonLoader(),
        );
      }),
    );
  }

  // #endregion
}
