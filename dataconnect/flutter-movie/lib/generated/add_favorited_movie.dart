part of movies;

class AddFavoritedMovieVariablesBuilder {
  String movieId;

  
  FirebaseDataConnect _dataConnect;
  
  AddFavoritedMovieVariablesBuilder(this._dataConnect, {required String this.movieId,});
  Deserializer<AddFavoritedMovieData> dataDeserializer = (dynamic json)  => AddFavoritedMovieData.fromJson(jsonDecode(json));
  Serializer<AddFavoritedMovieVariables> varsSerializer = (AddFavoritedMovieVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AddFavoritedMovieData, AddFavoritedMovieVariables>> execute() {
    return this.ref().execute();
  }
  MutationRef<AddFavoritedMovieData, AddFavoritedMovieVariables> ref() {
    AddFavoritedMovieVariables vars=AddFavoritedMovieVariables(movieId: movieId,);

    return _dataConnect.mutation("AddFavoritedMovie", dataDeserializer, varsSerializer, vars);
  }
}


  class AddFavoritedMovieFavoriteMovieUpsert {
  
   String userId;

  
   String movieId;

  
  
    
    
    
    AddFavoritedMovieFavoriteMovieUpsert.fromJson(dynamic json):
        userId = 
 
    nativeFromJson<String>(json['userId'])
  

        
        ,
      
        movieId = 
 
    nativeFromJson<String>(json['movieId'])
  

        
        
       {
      
        
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
      json['userId'] = 
  
    nativeToJson<String>(userId)
    
;
      
    
      
      json['movieId'] = 
  
    nativeToJson<String>(movieId)
    
;
      
    
    return json;
  }

  AddFavoritedMovieFavoriteMovieUpsert({
    
      required this.userId,
    
      required this.movieId,
    
  });
}



  class AddFavoritedMovieData {
  
   AddFavoritedMovieFavoriteMovieUpsert favorite_movie_upsert;

  
  
    
    
    
    AddFavoritedMovieData.fromJson(dynamic json):
        favorite_movie_upsert = 
 
    AddFavoritedMovieFavoriteMovieUpsert.fromJson(json['favorite_movie_upsert'])
  

        
        
       {
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
      json['favorite_movie_upsert'] = 
  
      favorite_movie_upsert.toJson()
  
;
      
    
    return json;
  }

  AddFavoritedMovieData({
    
      required this.favorite_movie_upsert,
    
  });
}



  class AddFavoritedMovieVariables {
  
   String movieId;

  
  
    
    
     @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
    
    
    AddFavoritedMovieVariables.fromJson(Map<String, dynamic> json):
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

  AddFavoritedMovieVariables({
    
      required this.movieId,
    
  });
}







