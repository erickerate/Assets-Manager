// ignore_for_file: unnecessary_this, unnecessary_null_comparison

import 'dart:ui';
import 'package:domain/domain.dart' as base;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ThemeModeView extends StatefulWidget {
  const ThemeModeView({super.key, this.onSelect});

  final void Function()? onSelect;

  @override
  State<ThemeModeView> createState() => _ThemeModeViewState();
}

class _ThemeModeViewState extends State<ThemeModeView> {
  // #region Members 'Builds' :: build()

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Observer(
        builder: (context) {
          bool isDarkTheme = Modular.get<base.IAppStore>().isDarkTheme;
          bool isLightTheme = Modular.get<base.IAppStore>().isLightTheme;
          bool isAutoTheme = Modular.get<base.IAppStore>().isAutoTheme;
          return Container(
            width: double.infinity,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: isDarkTheme
                  ? Colors.black.withOpacity(0.5)
                  : Colors.white.withOpacity(0.6),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // #region Introdução
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/light_mode.svg',
                        height: 50,
                        color: isDarkTheme
                            ? Theme.of(context).colorScheme.onPrimary
                            : const Color(0xFF1D1D1B),
                      ),
                      const Padding(padding: EdgeInsets.only(right: 21)),
                      SvgPicture.asset(
                        'assets/images/dark_mode.svg',
                        height: 39,
                        color: isDarkTheme
                            ? Theme.of(context).colorScheme.onPrimary
                            : const Color(0xFF1D1D1B),
                      ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 30)),
                  Text(
                    "Modo Claro / Escuro",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDarkTheme
                          ? Theme.of(context).colorScheme.onPrimary
                          : const Color(0xFF1D1D1B),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 11)),
                  Text(
                    "Escolha seu melhor modo de exibição",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: isDarkTheme
                          ? Theme.of(context).colorScheme.onPrimary
                          : const Color(0xFF1D1D1B),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 85)),
                  // #endregion
                  // #region Botões
                  SizedBox(
                    height: 57,
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: isAutoTheme
                            ? Theme.of(context).colorScheme.secondary
                            : isDarkTheme
                                ? Colors.white
                                : const Color(0xFF3d3d3d),
                      ),
                      child: Text(
                        "Automático",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isAutoTheme
                              ? Colors.white
                              : isDarkTheme
                                  ? const Color(0xFF333333)
                                  : Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        await Modular.get<base.IAppStore>()
                            .setThemeMode(base.ThemeMode.system);
                      },
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 11)),
                  SizedBox(
                    height: 57,
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: isLightTheme
                            ? Theme.of(context).colorScheme.secondary
                            : isDarkTheme
                                ? Colors.white
                                : const Color(0xFF3d3d3d),
                      ),
                      child: Text(
                        "Claro",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: !isAutoTheme && !isDarkTheme
                              ? Colors.white
                              : isDarkTheme
                                  ? const Color(0xFF333333)
                                  : Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        await Modular.get<base.IAppStore>()
                            .setThemeMode(base.ThemeMode.light);
                      },
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 11)),
                  SizedBox(
                    height: 57,
                    width: MediaQuery.of(context).size.width * 0.75,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: !isAutoTheme && isDarkTheme
                            ? Theme.of(context).colorScheme.secondary
                            : const Color(0xFF3d3d3d),
                      ),
                      child: Text(
                        "Escuro",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: !isAutoTheme && isDarkTheme
                              ? Colors.white
                              : isDarkTheme
                                  ? const Color(0xFF333333)
                                  : Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        await Modular.get<base.IAppStore>()
                            .setThemeMode(base.ThemeMode.dark);
                      },
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 46)),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Text(
                            "FECHAR",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isDarkTheme
                                  ? Colors.white
                                  : const Color(0xFF3d3d3d),
                            ),
                          ),
                          onTap: () async {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),

                  // #endregion
                ],
              ),
            ),
          );
        },
      ),
    );
  }
// #endregion
}
