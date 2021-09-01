class Movie {
  final int idEpisode;
  final String title;

  Movie.fromJson(Map<String, dynamic> json)
      : idEpisode = json['episode_id'] ?? -1,
        title = json['title'] ?? '';
}
