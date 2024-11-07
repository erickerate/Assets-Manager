// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:application/app/modules/assets/assets_module.dart';
import 'package:application/app/modules/companies/companies_store.dart';
import 'package:application/app/modules/companies/companies_view.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:service/service.dart';

class CompaniesModule extends Module {
  CompaniesModule();

  @override
  void binds(i) {
    i.addSingleton<ICompaniesStore>(CompaniesStore.new);
    i.add<IRepository<Company>>(CompaniesRepository.new);
    i.add<ServiceBase<Company>>(CompaniesService.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (_) => const CompaniesView());
    r.module('/assets', module: AssetsModule());
  }
}
