class Favorite {
  int id;
  String description;
  String type;

  Favorite(this.id, this.description, this.type);

  Favorite.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        description = map['description'],
        type = map['type'];

  int getId() => id;

  void setId(int value) {
    id = value;
  }

  String getDescription() => description;

  void setDescription(String value) {
    description = value;
  }

  String getType() => type;

  void setType(String value) {
    type = value;
  }
}
