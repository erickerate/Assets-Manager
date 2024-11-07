import 'package:domain/domain.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'companies_store.g.dart';

/// Implementação da loja de empresas com MobX
class CompaniesStore = CompaniesStoreBase with _$CompaniesStore;

abstract class CompaniesStoreBase with Store implements ICompaniesStore {
  // #region Constructors

  /// Implementação da loja de empresas com MobX
  CompaniesStoreBase() {
    this.service = Modular.get<ServiceBase<Company>>();
  }

  // #endregion

  // #region Members 'Service' :: service

  /// Serviço
  @override
  late ServiceBase<Company> service;

  // #endregion

  // #region Members 'Companies' :: companies, dispatchCompanies()

  /// Empresas
  @override
  @observable
  List<Company> companies = <Company>[];

  /// Definir listagem
  @override
  @action
  Future<void> dispatchCompanies() async {
    try {
      this.dispatchIsLoading(true);

      this.companies = await this.service.getAll();

      this.dispatchIsLoading(false);
    } catch (exception) {
      throw Exception('Fail in dispatchCompanies(): $exception');
    }
  }

  // #endregion

  // #region Members 'State' :: isLoading, dispatchIsLoading

  /// Está carregando?
  @override
  @observable
  bool isLoading = true;

  /// Despachar carregando
  @override
  @action
  Future<void> dispatchIsLoading(bool isLoading) async {
    try {
      this.isLoading = isLoading;
    } catch (exception) {
      throw Exception('Fail in dispatchIsLoading(): $exception');
    }
  }

  // #endregion
}
