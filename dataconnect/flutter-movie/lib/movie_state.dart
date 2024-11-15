import 'package:dataconnect/movies_connector/movies.dart';
import 'package:firebase_data_connect/firebase_data_connect.dart';

import 'models/movie.dart';

class MovieState {
  static void triggerUpdateFavorite() {
    MoviesConnector.instance.getCurrentUser().execute();
  }

  static Future<QueryResult<ListMoviesData, ListMoviesVariables>>
      getTopTenMovies() {
    return MoviesConnector.instance
        .listMovies()
        .orderByRating(OrderDirection.DESC)
        .limit(10)
        .execute();
  }

  static Future<QueryResult<ListMoviesData, ListMoviesVariables>>
      getLatestMovies() {
    return MoviesConnector.instance
        .listMovies()
        .orderByReleaseYear(OrderDirection.DESC)
        .execute();
  }

  static Stream<QueryResult<GetMovieByIdData, GetMovieByIdVariables>>
      subscribeToMovieById(String id) {
    return MoviesConnector.instance.getMovieById(id: id).ref().subscribe();
  }

  static void refreshMovieDetail(String id) {
    MoviesConnector.instance.getMovieById(id: id).execute();
    MoviesConnector.instance.getMovieInfoForUser(movieId: id).execute();
  }

  static Stream<
          QueryResult<GetMovieInfoForUserData, GetMovieInfoForUserVariables>>
      subscribeToGetMovieInfo(String id) {
    return MoviesConnector.instance
        .getMovieInfoForUser(movieId: id)
        .ref()
        .subscribe();
  }

  static Future<QueryResult<GetActorByIdData, GetActorByIdVariables>>
      getActorById(String actorId) {
    return MoviesConnector.instance.getActorById(id: actorId).execute();
  }

  static List<Movie> convertMainActorDetail(
      List<GetActorByIdActorMainActors> actors) {
    return actors
        .map(
          (e) => Movie(imageUrl: e.imageUrl, id: e.id, title: e.title),
        )
        .toList();
  }

  static List<Movie> convertSupportingActorDetail(
      List<GetActorByIdActorSupportingActors> actors) {
    return actors
        .map(
          (e) => Movie(imageUrl: e.imageUrl, id: e.id, title: e.title),
        )
        .toList();
  }

  static Stream<QueryResult<GetCurrentUserData, void>>
      subscribeToCurrentUser() {
    return MoviesConnector.instance.getCurrentUser().ref().subscribe();
  }

  static Future<void> toggleFavorite(String id, bool favorited) async {
    if (favorited) {
      await MoviesConnector.instance
          .deleteFavoritedMovie(movieId: id)
          .execute();
    } else {
      await MoviesConnector.instance.addFavoritedMovie(movieId: id).execute();
    }
    triggerUpdateFavorite();
  }
}
