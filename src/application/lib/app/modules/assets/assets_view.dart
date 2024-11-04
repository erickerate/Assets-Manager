import 'package:application/app/modules/assets/assets_store.dart';
import 'package:application/app/modules/assets/widgets/assets_tree_list_view.dart';
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
      WidgetsBinding.instance.addPostFrameCallback((_) async {});
    } catch (exception) {
      throw Exception("Fail in initState(): $exception");
    }
  }

  // #endregion

  // #region Members 'Store' :: controller, onRefresh()

  /// Controlador
  final controller = Modular.get<AssetsStore>();

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
            child: Text(
              "Assets / ${this.controller.assetsService.company.name!}",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
        leading: BackButton(
          color: Colors.white,
          onPressed: () async {
            Modular.to.pop();
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 104,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Color(0xFFEAEEF2)),
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: const Column(
                  children: [
                    Text("Filtro de texto"),
                    Text("Filtro de estado"),
                  ],
                ),
              ),
            ),
            const Flexible(
              child: TreeAssetsListView(),
            ),
          ],
        ),
      ),
    );
  }

  // #endregion
}
