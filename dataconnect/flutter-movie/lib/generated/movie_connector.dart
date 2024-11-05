library movies;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'dart:convert';

part 'upsert_user.dart';

part 'add_favorited_movie.dart';

part 'delete_favorited_movie.dart';

part 'add_review.dart';

part 'update_review.dart';

part 'delete_review.dart';

part 'list_movies.dart';

part 'get_movie_by_id.dart';

part 'get_actor_by_id.dart';

part 'get_current_user.dart';

part 'get_if_favorited_movie.dart';

part 'search_all.dart';



  enum OrderDirection {
    
      ASC,
    
      DESC,
    
  }
  OrderDirection orderDirectionDeserializer(dynamic data) {
    return OrderDirection.values.byName(data);
  }



String enumSerializer(Enum e) {
  return e.name;
}



class MovieConnectorConnector {
  
  
  UpsertUserVariablesBuilder upsertUser ({required String username,}) {
    return UpsertUserVariablesBuilder(dataConnect, username: username,);
  }
  
  
  AddFavoritedMovieVariablesBuilder addFavoritedMovie ({required String movieId,}) {
    return AddFavoritedMovieVariablesBuilder(dataConnect, movieId: movieId,);
  }
  
  
  DeleteFavoritedMovieVariablesBuilder deleteFavoritedMovie ({required String movieId,}) {
    return DeleteFavoritedMovieVariablesBuilder(dataConnect, movieId: movieId,);
  }
  
  
  AddReviewVariablesBuilder addReview ({required String movieId,required int rating,required String reviewText,}) {
    return AddReviewVariablesBuilder(dataConnect, movieId: movieId,rating: rating,reviewText: reviewText,);
  }
  
  
  UpdateReviewVariablesBuilder updateReview ({required String movieId,required int rating,required String reviewText,}) {
    return UpdateReviewVariablesBuilder(dataConnect, movieId: movieId,rating: rating,reviewText: reviewText,);
  }
  
  
  DeleteReviewVariablesBuilder deleteReview ({required String movieId,}) {
    return DeleteReviewVariablesBuilder(dataConnect, movieId: movieId,);
  }
  
  
  ListMoviesVariablesBuilder listMovies () {
    return ListMoviesVariablesBuilder(dataConnect, );
  }
  
  
  GetMovieByIdVariablesBuilder getMovieById ({required String id,}) {
    return GetMovieByIdVariablesBuilder(dataConnect, id: id,);
  }
  
  
  GetActorByIdVariablesBuilder getActorById ({required String id,}) {
    return GetActorByIdVariablesBuilder(dataConnect, id: id,);
  }
  
  
  GetCurrentUserVariablesBuilder getCurrentUser () {
    return GetCurrentUserVariablesBuilder(dataConnect, );
  }
  
  
  GetIfFavoritedMovieVariablesBuilder getIfFavoritedMovie ({required String movieId,}) {
    return GetIfFavoritedMovieVariablesBuilder(dataConnect, movieId: movieId,);
  }
  
  
  SearchAllVariablesBuilder searchAll ({required int minYear,required int maxYear,required double minRating,required double maxRating,required String genre,}) {
    return SearchAllVariablesBuilder(dataConnect, minYear: minYear,maxYear: maxYear,minRating: minRating,maxRating: maxRating,genre: genre,);
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'us-central1',
    'movie-connector',
    'fdc-quickstart-web',
  );

  MovieConnectorConnector({required this.dataConnect});
  static MovieConnectorConnector get instance {
    return MovieConnectorConnector(
        dataConnect: FirebaseDataConnect.instanceFor(
            connectorConfig: connectorConfig,
            sdkType: CallerSDKType.generated));
  }

  FirebaseDataConnect dataConnect;
}
