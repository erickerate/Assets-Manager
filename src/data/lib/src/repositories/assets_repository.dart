import 'dart:convert';
import 'package:domain/domain.dart';
import 'package:http/http.dart' as http;

/// Implementação do repositório de recursos utilizando requisições HTTP
class AssetsRepository implements IAssetsRepository {
  // #region Constructors

  /// Implementação do repositório de recursos utilizando requisições HTTP
  AssetsRepository();

  // #endregion

  // #region Members 'Owner' :: company

  /// Empresa
  @override
  late Company company;

  // #endregion

  // #region Members 'IRepository' :: getAll()

  /// Obter todos
  @override
  Future<List<Asset>> getAll() async {
    try {
      Uri url = Uri.https(
        'fake-api.tractian.com',
        '/companies/${this.company.id}/assets',
      );

      http.Response response = await http.get(url);

      List<Asset>? locations;
      if (response.statusCode == 200) {
        List<dynamic> jsonItems = json.decode(response.body);
        locations = jsonItems.map((json) => Asset.fromJson(json)).toList();
      }

      return locations ?? <Asset>[];
    } on Exception catch (exception) {
      throw Exception("Fail in getAll(): $exception");
    }
  }

  // #endregion
}
