class Avatar {
  final int id;
  String avatar;

  Avatar(this.id, this.avatar);

  Avatar.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        avatar = map['avatar'];

  int getId() {
    return id;
  }

  String getAvatar() {
    return avatar;
  }

  void setAvatar(String avatar) {
    this.avatar = avatar;
  }
}
