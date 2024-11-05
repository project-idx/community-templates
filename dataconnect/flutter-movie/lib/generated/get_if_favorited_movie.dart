part of movies;

class GetIfFavoritedMovieVariablesBuilder {
  String movieId;

  
  FirebaseDataConnect _dataConnect;
  
  GetIfFavoritedMovieVariablesBuilder(this._dataConnect, {required String this.movieId,});
  Deserializer<GetIfFavoritedMovieData> dataDeserializer = (dynamic json)  => GetIfFavoritedMovieData.fromJson(jsonDecode(json));
  Serializer<GetIfFavoritedMovieVariables> varsSerializer = (GetIfFavoritedMovieVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetIfFavoritedMovieData, GetIfFavoritedMovieVariables>> execute() {
    return this.ref().execute();
  }
  QueryRef<GetIfFavoritedMovieData, GetIfFavoritedMovieVariables> ref() {
    GetIfFavoritedMovieVariables vars=GetIfFavoritedMovieVariables(movieId: movieId,);

    return _dataConnect.query("GetIfFavoritedMovie", dataDeserializer, varsSerializer, vars);
  }
}


  class GetIfFavoritedMovieFavoriteMovie {
  
   String movieId;

  
  
    
    
    
    GetIfFavoritedMovieFavoriteMovie.fromJson(dynamic json):
        movieId = 
 
    nativeFromJson<String>(json['movieId'])
  

        
        
       {
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
      json['movieId'] = 
  
    nativeToJson<String>(movieId)
    
;
      
    
    return json;
  }

  GetIfFavoritedMovieFavoriteMovie({
    
      required this.movieId,
    
  });
}



  class GetIfFavoritedMovieData {
  
   GetIfFavoritedMovieFavoriteMovie? favorite_movie;

  
  
    
    
    
    GetIfFavoritedMovieData.fromJson(dynamic json):
        favorite_movie = json['favorite_movie'] == null ? null : 
 
    GetIfFavoritedMovieFavoriteMovie.fromJson(json['favorite_movie'])
  

        
        
       {
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
        if (favorite_movie != null) {
          json['favorite_movie'] = 
  
      favorite_movie!.toJson()
  
;
        }
      
    
    return json;
  }

  GetIfFavoritedMovieData({
    
       this.favorite_movie,
    
  });
}



  class GetIfFavoritedMovieVariables {
  
   String movieId;

  
  
    
    
     @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
    
    
    GetIfFavoritedMovieVariables.fromJson(Map<String, dynamic> json):
        movieId = 
 
    nativeFromJson<String>(json['movieId'])
  

        
        
       {
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
      json['movieId'] = 
  
    nativeToJson<String>(movieId)
    
;
      
    
    return json;
  }

  GetIfFavoritedMovieVariables({
    
      required this.movieId,
    
  });
}







