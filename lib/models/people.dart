class People {
  final int id;
  final String name;

  People.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        id = RegExp(r"/\/?([0-9_\-+]+)\/?(?:\;[^\/]*)?$")
                    .firstMatch(json['url']) !=
                null
            ? int.parse(RegExp(r"/\/?([0-9_\-+]+)\/?(?:\;[^\/]*)?$")
                .firstMatch(json['url'])!
                .group(1)!)
            : -1;
}
