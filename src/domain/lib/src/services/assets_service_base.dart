import 'package:domain/domain.dart';

/// Serviço abstrato para recursos
abstract class AssetsServiceBase extends ServiceBase<Asset> {
  /// Empresa
  Company get company;

  /// Filtros customizados
  List<AssetFilter> get customFilters {
    if (this._customfilters == null) {
      this._customfilters = <AssetFilter>[];
      this._customfilters!.add(EnergySensorTypeFilter());
      this._customfilters!.add(CriticalAssetStateFilter());
    }

    return this._customfilters!;
  }

  List<AssetFilter>? _customfilters;
}
