// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:application/app/modules/assets/assets_store.dart';
import 'package:application/app/modules/assets/assets_view.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:service/service.dart';

class AssetsModule extends Module {
  AssetsModule();

  @override
  void binds(i) {
    i.addInstance<Company>(i.args.data as Company);

    i.addInstance<IAssetsRepository>(AssetsRepository(
      company: i.get<Company>(),
    ));

    i.addInstance<IAssetsService>(AssetsService(
      repository: i.get<IAssetsRepository>(),
    ));

    i.addSingleton(AssetsStore.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (_) => const AssetsView());
  }
}
