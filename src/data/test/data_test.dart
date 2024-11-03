import 'package:data/data.dart';
import 'package:data/src/repositories/assets_repository.dart';
import 'package:data/src/repositories/locations_repository.dart';
import 'package:domain/domain.dart';
import 'package:test/test.dart';

void main() {
  group('Companies Repository', () {
    final repository = CompaniesRepository();

    test('Must get all companies', () async {
      final companies = await repository.getAll();

      expect(companies, isA<List<Company>>());
      expect(companies.length, greaterThan(0));
      expect(companies[0].name, isNotNull);
    });
  });

  group('Locations Repository', () {
    late Company company;

    setUp(() async {
      final companiesRepository = CompaniesRepository();
      final companies = await companiesRepository.getAll();
      company = companies.first;
    });

    test('Must get all locations', () async {
      final locationsRepository = LocationsRepository(company: company);

      final locations = await locationsRepository.getAll();

      expect(locations, isA<List<Location>>());
      expect(locations.length, greaterThan(0));
      expect(locations[0].name, isNotNull);
    });
  });

  group('Assets Repository', () {
    late Company company;

    setUp(() async {
      final companiesRepository = CompaniesRepository();
      final companies = await companiesRepository.getAll();
      company = companies.first;
    });

    test('Must get all assets', () async {
      final assetsRepository = AssetsRepository(company: company);

      final assets = await assetsRepository.getAll();

      expect(assets, isA<List<Asset>>());
      expect(assets.length, greaterThan(0));
      expect(assets[0].name, isNotNull);
    });
  });
}
