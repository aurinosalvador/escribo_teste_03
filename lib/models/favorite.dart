class Favorite {
  int _id;
  String _description;
  String _type;

  Favorite(this._id, this._description, this._type);

  Favorite.fromMap(Map<String, dynamic> map)
      : _id = map['id'],
        _description = map['description'],
        _type = map['type'];

  int getId() => _id;

  void setId(int value) {
    _id = value;
  }

  String getDescription() => _description;

  void setDescription(String value) {
    _description = value;
  }

  String getType() => _type;

  void setType(String value) {
    _type = value;
  }
}
