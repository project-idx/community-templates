part of movies_connector;

class DeleteFavoritedMovieVariablesBuilder {
  String movieId;

  
  FirebaseDataConnect _dataConnect;
  
  DeleteFavoritedMovieVariablesBuilder(this._dataConnect, {required String this.movieId,});
  Deserializer<DeleteFavoritedMovieData> dataDeserializer = (dynamic json)  => DeleteFavoritedMovieData.fromJson(jsonDecode(json));
  Serializer<DeleteFavoritedMovieVariables> varsSerializer = (DeleteFavoritedMovieVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteFavoritedMovieData, DeleteFavoritedMovieVariables>> execute() {
    return this.ref().execute();
  }
  MutationRef<DeleteFavoritedMovieData, DeleteFavoritedMovieVariables> ref() {
    DeleteFavoritedMovieVariables vars=DeleteFavoritedMovieVariables(movieId: movieId,);

    return _dataConnect.mutation("DeleteFavoritedMovie", dataDeserializer, varsSerializer, vars);
  }
}


  class DeleteFavoritedMovieFavoriteMovieDelete {
  
   String userId;

  
   String movieId;

  
  
    
    
    
    DeleteFavoritedMovieFavoriteMovieDelete.fromJson(dynamic json):
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

  DeleteFavoritedMovieFavoriteMovieDelete({
    
      required this.userId,
    
      required this.movieId,
    
  });
}



  class DeleteFavoritedMovieData {
  
   DeleteFavoritedMovieFavoriteMovieDelete? favorite_movie_delete;

  
  
    
    
    
    DeleteFavoritedMovieData.fromJson(dynamic json):
        favorite_movie_delete = json['favorite_movie_delete'] == null ? null : 
 
    DeleteFavoritedMovieFavoriteMovieDelete.fromJson(json['favorite_movie_delete'])
  

        
        
       {
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
        if (favorite_movie_delete != null) {
          json['favorite_movie_delete'] = 
  
      favorite_movie_delete!.toJson()
  
;
        }
      
    
    return json;
  }

  DeleteFavoritedMovieData({
    
       this.favorite_movie_delete,
    
  });
}



  class DeleteFavoritedMovieVariables {
  
   String movieId;

  
  
    
    
     @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
    
    
    DeleteFavoritedMovieVariables.fromJson(Map<String, dynamic> json):
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

  DeleteFavoritedMovieVariables({
    
      required this.movieId,
    
  });
}







