import 'package:application/app/themes/adapters/theme_mode_adapter.dart';
import 'package:domain/domain.dart' as base;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'themes/color_schemes.dart';
part 'themes/themes.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        base.ThemeMode themeMode = Modular.get<base.IAppStore>().themeMode;
        return MaterialApp.router(
          title: 'Assets Manager',
          debugShowCheckedModeBanner: false,
          theme: _lightTheme,
          darkTheme: _darkTheme,
          themeMode: ThemeModeAdapter.toMaterialThemeMode(themeMode),
          routerConfig: Modular.routerConfig,
        );
      },
    );
  }
}
