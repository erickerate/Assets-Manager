import 'package:domain/domain.dart';
import 'package:test/test.dart';

void main() {
  group('Location Entity :: ', () {
    test('Must serialize', () async {
      Location location = Location(
          id: "6a9b31a1b62cbf0062dd8a89",
          name: "Processing Unit 1",
          parentId: "6a944484aac55c0062464050");

      final json = location.toJson();

      expect(json, {
        'id': "6a9b31a1b62cbf0062dd8a89",
        'name': 'Processing Unit 1',
        'parentId': '6a944484aac55c0062464050'
      });
    });

    test('Must deserialize', () async {
      final json = {
        'id': "6a9b31a1b62cbf0062dd8a89",
        'name': 'Processing Unit 1',
        'parentId': '6a944484aac55c0062464050'
      };
      Location location = Location.fromJson(json);

      expect(location.id, json["id"]);
      expect(location.name, json["name"]);
      expect(location.parentId, json["parentId"]);
    });
  });
}
