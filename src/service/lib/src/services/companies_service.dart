import 'package:domain/domain.dart';

/// Serviço para empresas
class CompaniesService implements ServiceBase<Company> {
  // #region Constructors

  /// Serviço para empresas
  CompaniesService({required this.repository});

  // #endregion

  // #region Members 'IRepository' :: repository

  /// Repositório
  @override
  IRepository<Company> repository;

  // #endregion

  // #region Members 'Service' :: getAll()

  /// Obter todas empresas
  @override
  Future<List<Company>> getAll() async {
    try {
      List<Company> companies = await this.repository.getAll();
      return companies;
    } on Exception catch (exception) {
      throw Exception("Fail in getAll(): $exception");
    }
  }

  // #endregion
}
