// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:application/app/modules/companies/companies_module.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  AppModule();

  @override
  void binds(i) {
    // i.add<IRepository<Company>>(CompaniesRepository.new);
    // i.add<IService<Company>>(CompaniesService.new);
  }

  @override
  void routes(r) {
    r.module('/', module: CompaniesModule());
  }
}
