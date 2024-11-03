import 'package:domain/domain.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:service/service.dart';
part 'companies_store.g.dart';

/// Loja de empresas
class CompaniesStore = _CompaniesStoreBase with _$CompaniesStore;

abstract class _CompaniesStoreBase with Store {
  // #region Constructors

  _CompaniesStoreBase() {
    this.service = Modular.get<IService<Company>>();
  }

  // #endregion

  // #region Members 'Service' :: service

  /// Serviço
  late IService<Company> service;

  // #endregion

  // #region Members 'Companies' :: companies, queryCompanies()

  /// Empresas
  @observable
  List<Company> companies = <Company>[];

  /// Definir listagem
  @action
  Future<void> queryCompanies() async {
    try {
      this.setIsLoading(true);

      this.companies = await this.service.getAll();

      this.setIsLoading(false);
    } catch (exception) {
      throw Exception('Fail in queryCompanies(): $exception');
    }
  }

  // #endregion

  // #region Members 'State' :: isLoading, setIsLoading

  @observable
  bool isLoading = true;

  /// Definir carregando
  @action
  Future<void> setIsLoading(bool isLoading) async {
    try {
      this.isLoading = isLoading;
    } catch (exception) {
      throw Exception('Fail in setIsLoading(): $exception');
    }
  }

  // #endregion
}
