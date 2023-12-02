import 'dart:convert';

class ActorTV {
  int id;
  String name;
  String posterPath;
  String firstairdate;

  ActorTV({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.firstairdate,
  });

  factory ActorTV.fromMap(Map<String, dynamic> map) {
    return ActorTV(
      id: map['id'] as int,
      name: map['name'] ?? '',
      posterPath: map['poster_path'] ?? '',
      firstairdate: map['first_air_date'] ?? '',
    );
  }

  factory ActorTV.fromJson(String source) =>
      ActorTV.fromMap(json.decode(source));

  String getFoto() => posterPath == null
      ? 'http://forum.spaceengine.org/styles/se/theme/images/no_avatar.jpg'
      : 'https://image.tmdb.org/t/p/w500/$posterPath';
}
