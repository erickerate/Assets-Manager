import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

class AssetStateFilterWidget extends StatefulWidget {
  const AssetStateFilterWidget({
    super.key,
    required this.stateFilterEnum,
    required this.isSelected,
    required this.onSelect,
    required this.icon,
    this.debounceDuration = 0,
  });

  /// Filtro de estado
  final AssetFilter stateFilterEnum;

  /// Está selecionado?
  final bool isSelected;

  /// Ao selecionar
  final Future<void> Function(AssetFilter fiter) onSelect;

  /// Duração do estrangulador (ms)
  final int debounceDuration;

  /// Ícone
  final IconData icon;

  @override
  State<AssetStateFilterWidget> createState() =>
      _AssetStateFilterWidgetState();
}

class _AssetStateFilterWidgetState extends State<AssetStateFilterWidget> {
  // #region Members 'Debounce' :: throttling

  /// Estrangulador
  Future<void> throttling() async {
    try {
      if (this.throttleTimer != null) {
        this.throttleTimer!.cancel();
      }

      this.throttleTimer =
          Timer(Duration(milliseconds: this.widget.debounceDuration), () async {
        await this.widget.onSelect(this.widget.stateFilterEnum);
      });
    } catch (exception) {
      throw Exception("Fail in throttling(): $exception");
    }
  }

  /// Timer
  Timer? throttleTimer;

  // #endregion

  // #region Members 'Builds' :: build()

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await this.throttling();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color:
              this.widget.isSelected ? const Color(0xFF2188FF) : Colors.white,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
            width: 1,
            color: this.widget.isSelected
                ? Colors.transparent
                : const Color(0xFFD8DFE6),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              this.widget.icon,
              color: this.widget.isSelected
                  ? Colors.white
                  : const Color(0xFF77818C),
              size: 16,
            ),
            const Padding(padding: EdgeInsets.only(right: 6)),
            Text(
              this.widget.stateFilterEnum.description,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: this.widget.isSelected
                      ? Colors.white
                      : const Color(0xFF77818C)),
            ),
          ],
        ),
      ),
    );
  }

  // #endregion
}
