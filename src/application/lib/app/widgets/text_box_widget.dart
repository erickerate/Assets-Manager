import 'dart:async';

import 'package:flutter/material.dart';

class TextBoxWidget extends StatefulWidget {
  const TextBoxWidget({
    super.key,
    this.height,
    this.hintText,
    this.prefixIcon,
    this.onValueChanged,
    this.debounceDuration = 800,
  });

  final double? height;
  final String? hintText;
  final Widget? prefixIcon;

  /// Duração do estrangulador (ms)
  final int debounceDuration;

  final Future<void> Function(String value)? onValueChanged;

  @override
  State<TextBoxWidget> createState() => _TextBoxWidgetState();
}

class _TextBoxWidgetState extends State<TextBoxWidget> {
  // #region Members 'Debounce' :: throttling

  /// Estrangulador
  Future<void> throttling(String? text) async {
    try {
      if (this.throttleTimer != null) {
        this.throttleTimer!.cancel();
      }

      this.throttleTimer =
          Timer(Duration(milliseconds: this.widget.debounceDuration), () async {
        if (this.widget.onValueChanged != null) {
          this.widget.onValueChanged!(text ?? "");
        }
      });
    } catch (exception) {
      throw Exception("Fail in throttling(): $exception");
    }
  }

  /// Timer
  Timer? throttleTimer;

  // #endregion

  // #region Members 'Builds' :: build()

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: this.widget.height,
      child: TextFormField(
        controller: this.controller,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.none,
          decorationThickness: 0,
        ),
        cursorColor: Theme.of(context).colorScheme.onSurface,
        decoration: InputDecoration(
          filled: true,
          contentPadding: EdgeInsets.zero,
          fillColor: Theme.of(context).colorScheme.surface,
          hintText: this.widget.hintText,
          hintStyle: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: Theme.of(context).colorScheme.onSurface,
          ),
          suffixIcon: this.controller.text.isEmpty
              ? null
              : IconButton(
                  visualDensity: VisualDensity.compact,
                  icon: Icon(
                    Icons.close,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                  onPressed: () {
                    this.controller.clear();
                    this.setState(() {});
                    if (this.widget.onValueChanged != null) {
                      this.widget.onValueChanged!("");
                    }
                  },
                ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(4),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        onChanged: (value) async {
          this.setState(() {});
          this.throttling(value);
        },
      ),
    );
  }

  // #endregion
}
