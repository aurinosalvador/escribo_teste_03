class Movie {
  final int id;
  final String title;

  Movie.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        id = RegExp(r"/\/?([0-9_\-+]+)\/?(?:\;[^\/]*)?$")
                    .firstMatch(json['url']) !=
                null
            ? int.parse(RegExp(r"/\/?([0-9_\-+]+)\/?(?:\;[^\/]*)?$")
                .firstMatch(json['url'])!
                .group(1)!)
            : -1;
}