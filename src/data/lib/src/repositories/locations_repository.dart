import 'dart:convert';
import 'package:domain/domain.dart';
import 'package:http/http.dart' as http;

/// Implementação do repositório de localizações utilizando requisições HTTP
class LocationsRepository implements ILocationsRepository {
  // #region Constructors

  /// Implementação do repositório de localizações utilizando requisições HTTP
  LocationsRepository();

  // #endregion

  // #region Members 'Owner' :: company

  /// Empresa
  @override
  late Company company;

  // #endregion

  // #region Members 'IRepository' :: getAll()

  /// Obter todos
  @override
  Future<List<Location>> getAll() async {
    try {
      Uri url = Uri.https(
        'fake-api.tractian.com',
        '/companies/${this.company.id}/locations',
      );

      http.Response response = await http.get(url);

      List<Location>? locations;
      if (response.statusCode == 200) {
        List<dynamic> jsonItems = json.decode(response.body);
        locations = jsonItems.map((json) => Location.fromJson(json)).toList();
      }

      return locations ?? <Location>[];
    } on Exception catch (exception) {
      throw Exception("Fail in getAll(): $exception");
    }
  }

  // #endregion
}
