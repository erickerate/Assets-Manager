import 'package:domain/domain.dart';
import 'package:test/test.dart';

void main() {
  group('Asset Entity :: ', () {
    test('Must serialize', () async {
      Asset asset = Asset(
        id: "6a9b48fdb62cbf0062dd5c2d",
        name: "Sensor 67 - energy",
        parentId: null,
        gatewayId: "ZBY751",
        locationId: "6a9b45c2cac55c00624640fc",
        sensorId: "LMJ175",
        sensorType: "energy",
        status: "operating",
      );

      final json = asset.toJson();

      expect(json, {
        "id": "6a9b48fdb62cbf0062dd5c2d",
        "name": "Sensor 67 - energy",
        "parentId": null,
        "gatewayId": "ZBY751",
        "locationId": "6a9b45c2cac55c00624640fc",
        "sensorId": "LMJ175",
        "sensorType": "energy",
        "status": "operating"
      });
    });

    test('Must deserialize', () async {
      final json = {
        "id": "6a9b48fdb62cbf0062dd5c2d",
        "name": "Sensor 67 - energy",
        "parentId": null,
        "gatewayId": "ZBY751",
        "locationId": "6a9b45c2cac55c00624640fc",
        "sensorId": "LMJ175",
        "sensorType": "energy",
        "status": "operating"
      };
      Asset asset = Asset.fromJson(json);

      expect(asset.id, json["id"]);
      expect(asset.name, json["name"]);
      expect(asset.parentId, json["parentId"]);
      expect(asset.gatewayId, json["gatewayId"]);
      expect(asset.locationId, json["locationId"]);
      expect(asset.sensorId, json["sensorId"]);
      expect(asset.sensorType, json["sensorType"]);
      expect(asset.status, json["status"]);
    });
  });
}
