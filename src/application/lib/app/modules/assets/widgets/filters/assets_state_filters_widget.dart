import 'package:application/app/modules/assets/assets_store.dart';
import 'package:application/app/modules/assets/widgets/filters/assets_state_filter_widget.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AssetsStateFiltersWidget extends StatefulWidget {
  const AssetsStateFiltersWidget({super.key});

  @override
  State<AssetsStateFiltersWidget> createState() =>
      _AssetsStateFiltersWidgetState();
}

class _AssetsStateFiltersWidgetState extends State<AssetsStateFiltersWidget> {
  // #region Members 'Store' :: controller, onSelect()

  /// Controlador
  final controller = Modular.get<AssetsStore>();

  /// Ao selecionar
  Future<void> onSelect(AssetsStateFilter filter) async {
    try {
      await this.controller.selectFilter(filter);
      // await this.controller.refresh();
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
            this.controller.allFilters.length,
            (index) {
              bool isFirst = index == 0;
              AssetsStateFilter filter = this.controller.allFilters[index];
              IconData iconData = filter.number == "critical"
                  ? Icons.error_outline
                  : Icons.bolt_outlined;
              return Observer(
                builder: (_) {
                  return Padding(
                    padding: EdgeInsets.only(left: isFirst ? 0 : 8),
                    child: AssetsStateFilterWidget(
                      stateFilterEnum: filter,
                      icon: iconData,
                      isSelected:
                          this.controller.selectedFilters.contains(filter),
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
