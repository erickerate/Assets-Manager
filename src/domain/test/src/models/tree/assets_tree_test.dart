import 'dart:convert';
import 'dart:io';
import 'package:darq/darq.dart';
import 'package:domain/domain.dart';
import 'package:test/test.dart';

void main() {
  group('Entities', () {
    test('Must serialize Company entity', () async {
      Company company = Company(id: "662fd0ee639069143a8fc387", name: "Jaguar");

      final json = company.toJson();

      expect(json, {'id': "662fd0ee639069143a8fc387", 'name': 'Jaguar'});
    });
    test('Must deserialize Company entity', () async {
      final json = {'id': "662fd0ee639069143a8fc387", 'name': 'Jaguar'};

      Company company = Company.fromJson(json);

      expect(company.id, json["id"]);
      expect(company.name, json["name"]);
    });

    test('Must serialize Location entity', () async {
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

    test('Must deserialize Location entity', () async {
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

    test('Must serialize Asset entity', () async {
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

    test('Must deserialize Asset entity', () async {
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

/// Validar hierarquia dos itens
bool validateAssetsTreeHierarchy(List<TreeItem> treeItems) {
  for (TreeItem treeItem in treeItems) {
    bool isValid = validateTreeItemHierarchy(treeItem);
    if (!isValid) return false;
  }

  return true;
}

/// Validar hierarquia do item
bool validateTreeItemHierarchy(TreeItem treeItem) {
  for (TreeItem child in treeItem.children) {
    if (child.parent != treeItem) return false;

    if (!validateTreeItemHierarchy(child)) {
      return false;
    }
  }

  return true;
}
