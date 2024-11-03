/// Recurso
class Asset {
  // #region Constructors

  /// Recurso
  Asset(
      {this.gatewayId,
      this.id,
      this.locationId,
      this.name,
      this.parentId,
      this.sensorId,
      this.sensorType,
      this.status});

  // #endregion

  // #region Members 'Primary Properties: Header' :: id, name, status

  /// Id registro
  String? id;

  /// Nome
  String? name;

  /// Status
  String? status;

  // #endregion

  // #region Members 'Primary Properties: Owner' :: gatewayId, locationId, parentId

  /// Id porta de entrada
  String? gatewayId;

  /// Localização
  String? locationId;

  /// Id pai (Asset)
  String? parentId;

  // #endregion

  // #region Members 'Primary Properties: Component' :: sensorId, sensorType

  /// Id sensor
  String? sensorId;

  /// Tipo de sensor
  String? sensorType;

  // #endregion

  // #region Members 'Serialization' :: fromJson(), toJson()

  /// Json -> Object
  Asset.fromJson(Map<String, dynamic> json) {
    gatewayId = json['gatewayId'];
    id = json['id'];
    locationId = json['locationId'];
    name = json['name'];
    parentId = json['parentId'];
    sensorId = json['sensorId'];
    sensorType = json['sensorType'];
    status = json['status'];
  }

  /// Object -> Json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gatewayId'] = this.gatewayId;
    data['id'] = this.id;
    data['locationId'] = this.locationId;
    data['name'] = this.name;
    data['parentId'] = this.parentId;
    data['sensorId'] = this.sensorId;
    data['sensorType'] = this.sensorType;
    data['status'] = this.status;
    return data;
  }

  // #endregion
}
