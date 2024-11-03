import 'dart:convert';
import 'package:domain/domain.dart';
import 'package:http/http.dart' as http;

/// Implementação do repositório de empresas utilizando requisições HTTP
class CompaniesRepository implements IRepository<Company> {
  // #region Members 'IRepository' :: getAll()

  /// Obter todos
  @override
  Future<List<Company>> getAll() async {
    try {
      Uri url = Uri.https(
        'fake-api.tractian.com',
        '/companies',
      );

      http.Response response = await http.get(url);

      List<Company>? companies;
      if (response.statusCode == 200) {
        List<dynamic> jsonItems = json.decode(response.body);
        companies = jsonItems.map((json) => Company.fromJson(json)).toList();
      }

      return companies ?? <Company>[];
    } on Exception catch (exception) {
      throw Exception("Fail in getAll(): $exception");
    }
  }

  // #endregion
}
