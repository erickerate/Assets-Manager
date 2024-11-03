/// Empresa
class Company {
  // #region Constructors

  /// Empresa
  Company({this.id, this.name});

  // #endregion

  // #region Members 'Primary Properties' :: id, name

  /// Identificador registro
  String? id;

  /// Nome
  String? name;

  // #endregion

  // #region Members 'Serialization' :: fromJson(), toJson()

  /// Json -> Object
  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  /// Object -> Json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  // #endregion
}
