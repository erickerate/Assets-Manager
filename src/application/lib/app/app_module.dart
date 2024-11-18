// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:application/app/app_store.dart';
import 'package:application/app/modules/companies/companies_module.dart';
import 'package:application/app/providers/shared_preferences_provider.dart';
import 'package:domain/domain.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  AppModule();

  @override
  void binds(i) {
    i.add<IPreferencesProvider>(SharedPreferencesProvider.new);
    i.addSingleton<IAppStore>(AppStore.new);
  }

  @override
  void routes(r) {
    r.module('/', module: CompaniesModule());
  }
}
