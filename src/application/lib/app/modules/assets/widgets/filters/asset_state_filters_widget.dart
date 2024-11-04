import 'package:application/app/modules/assets/assets_store.dart';
import 'package:application/app/modules/assets/widgets/filters/asset_state_filter_widget.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AssetStateFiltersWidget extends StatefulWidget {
  const AssetStateFiltersWidget({super.key});

  @override
  State<AssetStateFiltersWidget> createState() =>
      _AssetStateFiltersWidgetState();
}

class _AssetStateFiltersWidgetState extends State<AssetStateFiltersWidget> {
  // #region Members 'Store' :: controller, onSelect()

  /// Controlador
  final controller = Modular.get<AssetsStore>();

  /// Ao selecionar
  Future<void> onSelect(AssetFilter filter) async {
    try {
      await this.controller.selectCustomFilter(filter);
      this.controller.refresh();
    } on Exception catch (exception) {
      throw Exception("Fail in onSelect(): $exception");
    }
  }

  // #endregion

  // #region Members 'Builds' :: build()

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: List.generate(
            this.controller.customFilters.length,
            (index) {
              bool isFirst = index == 0;
              AssetFilter filter = this.controller.customFilters[index];
              IconData iconData = filter.number == "critical"
                  ? Icons.error_outline
                  : Icons.bolt_outlined;
              return Observer(
                builder: (_) {
                  return Padding(
                    padding: EdgeInsets.only(left: isFirst ? 0 : 8),
                    child: AssetStateFilterWidget(
                      stateFilterEnum: filter,
                      icon: iconData,
                      isSelected:
                          this.controller.selectedCustomFilters.contains(filter),
                      onSelect: this.onSelect,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  // #endregion
}
