class PropertyType {
  var _id;
  var _name;

  PropertyType(this._id, this._name);

  PropertyType.fromJson(Map<String, dynamic> json)
      : _id = json['id'],
        _name = json['name'];

  @override
  String toString() {
    return _name;
  }


}
