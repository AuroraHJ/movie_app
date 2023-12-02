import 'dart:convert';

class Movie {
  int id;
  String title;
  String posterPath;
  String backdropPath;
  String overview;
  String releaseDate;
  double voteAverage;
  List<int> genreIds;
  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.genreIds,
  });

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as int,
      title: map['title'] ?? '',
      posterPath: map['poster_path'] ?? '',
      backdropPath: map['backdrop_path'] ?? '',
      overview: map['overview'] ?? '',
      releaseDate: map['release_date'] ?? '',
      voteAverage: map['vote_average']?.toDouble() ?? 0.0,
      genreIds: List<int>.from(map['genre_ids']),
    );
  }

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));
}

class Actor {
  int id;
  String name;
  String profilePath;
  double popularity;

  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.popularity,
  });

  factory Actor.fromMap(Map<String, dynamic> map) {
    return Actor(
      id: map['id'] as int,
      name: map['original_name'] ?? '',
      profilePath: map['profile_path'] ?? '',
      popularity: map['popularity'] ?? '',
    );
  }

  factory Actor.fromJson(String source) => Actor.fromMap(json.decode(source));
}

class Detail {
  int id;
  String name;
  String profilePath;
  double popularity;
  String birthday;
  String biography;

  Detail({
    required this.id,
    required this.name,
    required this.profilePath,
    required this.popularity,
    required this.birthday,
    required this.biography,
  });

  factory Detail.fromMap(Map<String, dynamic> map) {
    return Detail(
      id: map['id'] as int,
      name: map['name'] ?? '',
      profilePath: map['profile_path'] ?? '',
      popularity: map['popularity'] ?? '',
      birthday: map['birthday'] ?? '',
      biography: map['biography'] ?? '',
    );
  }

  factory Detail.fromJson(String source) => Detail.fromMap(json.decode(source));
}
