import 'dart:convert';
import 'dart:io';

import 'package:application/app/modules/companies/companies_module.dart';
import 'package:application/app/modules/companies/widgets/company_list_view.dart';
import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:service/service.dart';
import 'package:skeleton_loader/skeleton_loader.dart';
import 'company_list_view_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CompaniesService>()])
void main() {
  final mockCompaniesService = MockCompaniesService();
  late List<Company> companies;

  setUp(() async {
    final File file = File('assets/mocks/companies.json');
    String jsonString = await file.readAsString();
    List<dynamic> items = json.decode(jsonString);
    companies = items.map((json) => Company.fromJson(json)).toList();
  });

  group('CompanyListView ::', () {
    testWidgets('Must correctly load the companies listing view',
        (WidgetTester tester) async {
      // #region Arrange

      when(mockCompaniesService.getAll()).thenAnswer((_) async => companies);

      Modular.replaceInstance<ServiceBase<Company>>(mockCompaniesService);
      Modular.init(CompaniesModule());

      ServiceBase<Company> companyService = Modular.get<ServiceBase<Company>>();
      List<Company> listageItems = await companyService.getAll();

      // #endregion

      // #region Act

      await tester.pumpWidget(
        const MaterialApp(
          home: CompanyListView(),
        ),
      );

      // #endregion

      // #region Assert

      // #region Estado inicial

      for (Company listageItem in listageItems) {
        String companyText = "${listageItem.name!} Unit";
        expect(find.text(companyText), findsNothing);
      }
      expect(find.byType(SkeletonLoader), findsOneWidget);

      // #endregion

      // #region Após carregar

      await tester.pumpAndSettle();

      for (Company listageItem in listageItems) {
        String companyText = "${listageItem.name!} Unit";
        expect(find.text(companyText), findsOneWidget);
      }
      expect(find.byType(SkeletonLoader), findsNothing);

      // #endregion

      // #endregion
    });
  });
}
