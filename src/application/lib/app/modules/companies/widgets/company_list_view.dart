import 'package:application/app/modules/companies/companies_store.dart';
import 'package:application/app/widgets/skeleton_loader_view.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'company_list_item_view.dart';

class CompanyListView extends StatefulWidget {
  const CompanyListView({super.key});

  @override
  State<CompanyListView> createState() => _CompanyListViewState();
}

class _CompanyListViewState extends State<CompanyListView> {
  // #region Members 'Overrides' :: initState()

  @override
  void initState() {
    try {
      super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        await this.onRefresh();
      });
    } catch (exception) {
      throw Exception("Fail in initState(): $exception");
    }
  }

  // #endregion

  // #region Members 'Store' :: controller, onRefresh()

  /// Controlador
  final controller = Modular.get<CompaniesStore>();

  /// Ao atualizar
  Future<void> onRefresh() async {
    try {
      await this.controller.queryCompanies();
    } catch (exception) {
      throw Exception("Fail in onRefreshing(): $exception");
    }
  }

  // #endregion

  // #region Members 'Company' :: onSelect()

  /// Ao selecionar
  Future<void> onSelect(Company company) async {
    try {
      await Modular.to.pushNamed('/assets/', forRoot: true, arguments: company);
    } on Exception catch (exception) {
      throw Exception("Fail in onSelect(): $exception");
    }
  }

  // #endregion

  // #region Members 'Build' :: build()

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: this.onRefresh,
      child: Observer(builder: (_) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 30),
          child: !this.controller.isLoading
              ? ListView.separated(
                  itemCount: this.controller.companies.length,
                  separatorBuilder: (context, index) {
                    return const Padding(padding: EdgeInsets.only(bottom: 40));
                  },
                  itemBuilder: (context, index) {
                    Company company = this.controller.companies[index];
                    return CompanyListItemView(
                      company: company,
                      onSelect: this.onSelect,
                    );
                  },
                )
              : const SkeletonLoaderView(),
        );
      }),
    );
  }

  // #endregion
}
