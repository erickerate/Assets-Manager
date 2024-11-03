/// Localização
class Location {
  // #region Constructors

  /// Localização
  Location({this.id, this.name, this.parentId});

  // #endregion

  // #region Members 'Primary Properties' :: id, name, parentId

  /// Identificador registro
  String? id;

  /// Nome
  String? name;

  /// Id pai
  String? parentId;

  // #endregion

  // #region Members 'Serialization' :: fromJson(), toJson()

  /// Json -> Object
  Location.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parentId'];
  }

  /// Object -> Json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['parentId'] = this.parentId;
    return data;
  }

  // #endregion
}
