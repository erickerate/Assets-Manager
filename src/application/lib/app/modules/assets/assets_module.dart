// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:application/app/modules/assets/assets_store.dart';
import 'package:application/app/modules/assets/assets_view.dart';
import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:service/service.dart';

import 'widgets/tree/tree_item_store.dart';

class AssetsModule extends Module {
  AssetsModule();

  @override
  void binds(i) {
    // Ativos
    i.addInstance<IAssetsRepository>(AssetsRepository());
    i.addInstance<AssetsServiceBase>(AssetsService(
      repository: i.get<IAssetsRepository>(),
    ));

    // Localizações
    i.addInstance<ILocationsRepository>(LocationsRepository());
    i.addInstance<LocationsServiceBase>(LocationsService(
      repository: i.get<ILocationsRepository>(),
    ));

    // Lojas
    i.add<ITreeItemStore>(TreeItemStore.new);
    i.addSingleton<IAssetsStore>(AssetsStore.new);
  }

  @override
  void routes(r) {
    r.child('/', child: (_) => const AssetsView());
  }
}
