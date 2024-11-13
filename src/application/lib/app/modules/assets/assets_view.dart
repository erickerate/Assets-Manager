import 'dart:isolate';
import 'package:application/app/modules/assets/widgets/filters/asset_state_filters_widget.dart';
import 'package:application/app/modules/assets/widgets/tree/tree_items_view.dart';
import 'package:application/app/widgets/text_box_widget.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AssetsView extends StatefulWidget {
  const AssetsView({super.key});

  @override
  State<AssetsView> createState() => _AssetsViewState();
}

class _AssetsViewState extends State<AssetsView> {
  // #region Members 'Overrides' :: initState()

  @override
  void initState() {
    try {
      super.initState();

      Modular.get<IAssetsStore>()
          .receivePort
          .listen(Modular.get<IAssetsStore>().listen);

      WidgetsBinding.instance.addPostFrameCallback((_) async {});
    } catch (exception) {
      throw Exception("Fail in initState(): $exception");
    }
  }

  // #endregion

  // #region Members 'Store' :: controller, onRefresh()

  /// Controlador
  final controller = Modular.get<IAssetsStore>();

  // #endregion

  // #region Members 'Builds' :: build()

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF17192D),
        automaticallyImplyLeading: true,
        flexibleSpace: SafeArea(
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/company.png",
                ),
                const Padding(padding: EdgeInsets.only(right: 6)),
                Text(
                  "Assets / ${this.controller.assetsService.company.name!} Unit",
                  style: const TextStyle(
                    color: Colors.white,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        leading: BackButton(
          color: Colors.white,
          onPressed: () async {
            Modular.get<IAssetsStore>()
                .isolate
                ?.kill(priority: Isolate.immediate);
            Modular.get<IAssetsStore>().receivePort.close();
            Modular.to.pop();
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // #region Filtros

            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xFFEAEEF2)),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextBoxWidget(
                      height: 32,
                      hintText: "Buscar Ativo ou Local",
                      onValueChanged: this.controller.onTextSearchFilterChanged,
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 8)),
                    const AssetStateFiltersWidget(),
                  ],
                ),
              ),
            ),

            // #endregion

            // #region Árvore

            const Flexible(
              child: TreeItemsView(),
            ),

            // #endregion
          ],
        ),
      ),
    );
  }

  // #endregion
}
