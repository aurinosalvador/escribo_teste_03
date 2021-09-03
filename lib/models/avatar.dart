class Avatar {
  final int id;
  String avatar;

  Avatar(this.id, this.avatar);

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
