import 'package:domain/domain.dart';

/// Interface: Loja de empresas
abstract class ICompaniesStore implements StoreBase {
  // #region Members 'Service' :: service

  /// Serviço
  late ServiceBase<Company> service;

  // #endregion

  // #region Members 'Companies' :: companies, dispatchCompanies()

  /// Empresas
  List<Company> companies = <Company>[];

  /// Despachar listagem
  Future<void> dispatchCompanies();

  // #endregion
}
