import 'package:domain/domain.dart';
import 'package:test/test.dart';

void main() {
  group('Company Entity :: ', () {
    test('Must serialize', () async {
      Company company = Company(id: "662fd0ee639069143a8fc387", name: "Jaguar");

      final json = company.toJson();

      expect(json, {'id': "662fd0ee639069143a8fc387", 'name': 'Jaguar'});
    });
    test('Must deserialize', () async {
      final json = {'id': "662fd0ee639069143a8fc387", 'name': 'Jaguar'};

      Company company = Company.fromJson(json);

      expect(company.id, json["id"]);
      expect(company.name, json["name"]);
    });
  });
}
