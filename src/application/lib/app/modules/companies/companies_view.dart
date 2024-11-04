import 'package:flutter/material.dart';

import 'widgets/company_list_view.dart';

class CompaniesView extends StatefulWidget {
  const CompaniesView({super.key});

  @override
  State<CompaniesView> createState() => _CompaniesViewState();
}

class _CompaniesViewState extends State<CompaniesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF17192D),
        flexibleSpace: SafeArea(
          child: Image.asset(
            "assets/images/logo.png",
          ),
        ),
      ),
      body: const CompanyListView(),
    );
  }
}
