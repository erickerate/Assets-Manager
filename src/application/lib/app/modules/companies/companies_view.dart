import 'dart:ui';

import 'package:application/app/themes/theme_mode_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'widgets/company_list_view.dart';

class CompaniesView extends StatefulWidget {
  const CompaniesView({super.key});

  @override
  State<CompaniesView> createState() => _CompaniesViewState();
}

class _CompaniesViewState extends State<CompaniesView> {
  Future<void> onChangeThemeMode() async {
    await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: const ThemeModeView(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        flexibleSpace: SafeArea(
          child: Image.asset(
            "assets/images/logo.png",
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              await this.onChangeThemeMode();
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 21),
              child: SvgPicture.asset(
                'assets/images/theme_mode.svg',
                width: 27,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ],
      ),
      body: const CompanyListView(),
    );
  }
}
