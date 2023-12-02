import 'dart:convert';
import 'package:movies_app/api/api.dart';
import 'package:movies_app/models/movie.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/review.dart';
import 'package:movies_app/models/actorMovie.dart';
import 'package:movies_app/models/actorTv.dart';

class ApiService {
  static Future<List<Actor>?> getActors() async {
    List<Actor> actors = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}person/popular?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].skip(6).forEach(
            (a) => actors.add(
              Actor.fromMap(a),
            ),
          );
      return actors;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Detail>?> getDetails(int id) async {
    List<Detail> details = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}person/$id?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);

      details.add(
        Detail(
          id: res['id'],
          name: res['name'],
          profilePath: res['profile_path'],
          popularity: res['popularity'],
          birthday: res['birthday'],
          biography: res['biography'],
        ),
      );
      return details;
    } catch (e) {
      print('Error en la solicitud: $e');
      return null;
    }
  }

  static Future<List<Actor>?> getCustomActors(String url) async {
    List<Actor> actors = [];
    try {
      http.Response response =
          await http.get(Uri.parse('${Api.baseUrl}person/$url'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
        (a) => actors.add(
          Actor.fromMap(a),
        ),
      );
      return actors;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Actor>?> getSearchedActors(String query) async {
    List<Actor> actors = [];
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/person/popular?api_key=${Api.apiKey}&language=en-US&query=$query&page=1&include_adult=false'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
        (a) => actors.add(
          Actor.fromMap(a),
        ),
      );
      return actors;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Review>?> getMovieReviews(int movieId) async {
    List<Review> reviews = [];
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/$movieId/reviews?api_key=${Api.apiKey}&language=en-US&page=1'));
      var res = jsonDecode(response.body);
      res['results'].forEach(
        (r) {
          reviews.add(
            Review(
                author: r['author'],
                comment: r['content'],
                rating: r['author_details']['rating']),
          );
        },
      );
      return reviews;
    } catch (e) {
      return null;
    }
  }

  static Future<List<ActorMovie>> getActorMovie(String actorName) async {
    List<ActorMovie> cast = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}person/popular?api_key=${Api.apiKey}&language=en-US&page=1'));

      var castData = jsonDecode(response.body)['results'];
      var actor = castData.firstWhere(
        (personData) => personData['name']
            .toString()
            .toLowerCase()
            .contains(actorName.toLowerCase()),
        orElse: () => null,
      );

      if (actor != null) {
        var knownFor = actor['known_for'] as List<dynamic>;
        for (var movieData in knownFor) {
          if (movieData['media_type'] == 'movie') {
            cast.add(
              ActorMovie(
                id: movieData['id'] as int,
                title: movieData['title'] ?? '',
                posterPath: movieData['poster_path'] ?? '',
                releaseDate: movieData['release_date'] ?? '',
              ),
            );
          }
        }
      }

      return cast;
    } catch (e) {
      return [];
    }
  }

  static Future<List<ActorTV>> getActorSerie(String actorName) async {
    List<ActorTV> cast = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}person/popular?api_key=${Api.apiKey}&language=en-US&page=1'));

      var castData = jsonDecode(response.body)['results'];
      var actor = castData.firstWhere(
        (personData) => personData['name']
            .toString()
            .toLowerCase()
            .contains(actorName.toLowerCase()),
        orElse: () => null,
      );

      if (actor != null) {
        var knownFor = actor['known_for'] as List<dynamic>;
        for (var movieData in knownFor) {
          if (movieData['media_type'] == 'tv') {
            cast.add(
              ActorTV(
                id: movieData['id'] as int,
                name: movieData['name'] ?? '',
                posterPath: movieData['poster_path'] ?? '',
                firstairdate: movieData['first_air_date'] ?? '',
              ),
            );
          }
        }
      }

      return cast;
    } catch (e) {
      return [];
    }
  }
}
