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
          await this.widget.onValueChanged!(text ?? "");
        }
      });
    } catch (exception) {
      throw Exception("Fail in throttling(): $exception");
    }
  }

  /// Timer
  Timer? throttleTimer;

  // #endregion

  // #region Members 'Builds' ::

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: this.widget.height,
      child: TextFormField(
        style: const TextStyle(
          color: Color(0XFF8E98A3),
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.none,
          decorationThickness: 0,
        ),
        cursorColor: const Color(0XFF8E98A3),
        decoration: InputDecoration(
          filled: true,
          contentPadding: EdgeInsets.zero,
          fillColor: const Color(0xFFEAEFF3),
          hintText: this.widget.hintText,
          hintStyle: const TextStyle(
            color: Color(0XFF8E98A3),
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0XFF8E98A3),
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
          await this.throttling(value);
        },
      ),
    );
  }

  // #endregion
}
