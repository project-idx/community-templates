part of movies;

class GetCurrentUserVariablesBuilder {
  
  
  FirebaseDataConnect _dataConnect;
  
  GetCurrentUserVariablesBuilder(this._dataConnect, );
  Deserializer<GetCurrentUserData> dataDeserializer = (dynamic json)  => GetCurrentUserData.fromJson(jsonDecode(json));
  
  Future<QueryResult<GetCurrentUserData, void>> execute() {
    return this.ref().execute();
  }
  QueryRef<GetCurrentUserData, void> ref() {
    
    return _dataConnect.query("GetCurrentUser", dataDeserializer, emptySerializer, null);
  }
}


  class GetCurrentUserUser {
  
   String id;

  
   String username;

  
   List<GetCurrentUserUserReviews> reviews;

  
   List<GetCurrentUserUserFavoriteMovies> favoriteMovies;

  
  
    
    
    
    GetCurrentUserUser.fromJson(dynamic json):
        id = 
 
    nativeFromJson<String>(json['id'])
  

        
        ,
      
        username = 
 
    nativeFromJson<String>(json['username'])
  

        
        ,
      
        reviews = 
 
    
      (json['reviews'] as List<dynamic>)
        .map((e) => GetCurrentUserUserReviews.fromJson(e))
        .toList()
    
  

        
        ,
      
        favoriteMovies = 
 
    
      (json['favoriteMovies'] as List<dynamic>)
        .map((e) => GetCurrentUserUserFavoriteMovies.fromJson(e))
        .toList()
    
  

        
        
       {
      
        
      
        
      
        
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
      json['id'] = 
  
    nativeToJson<String>(id)
    
;
      
    
      
      json['username'] = 
  
    nativeToJson<String>(username)
    
;
      
    
      
      json['reviews'] = 
  
    
      reviews.map((e) => e.toJson()).toList()
    
  
;
      
    
      
      json['favoriteMovies'] = 
  
    
      favoriteMovies.map((e) => e.toJson()).toList()
    
  
;
      
    
    return json;
  }

  GetCurrentUserUser({
    
      required this.id,
    
      required this.username,
    
      required this.reviews,
    
      required this.favoriteMovies,
    
  });
}



  class GetCurrentUserUserReviews {
  
   String id;

  
   int? rating;

  
   DateTime reviewDate;

  
   String? reviewText;

  
   GetCurrentUserUserReviewsMovie movie;

  
  
    
    
    
    GetCurrentUserUserReviews.fromJson(dynamic json):
        id = 
 
    nativeFromJson<String>(json['id'])
  

        
        ,
      
        rating = json['rating'] == null ? null : 
 
    nativeFromJson<int>(json['rating'])
  

        
        ,
      
        reviewDate = 
 
    nativeFromJson<DateTime>(json['reviewDate'])
  

        
        ,
      
        reviewText = json['reviewText'] == null ? null : 
 
    nativeFromJson<String>(json['reviewText'])
  

        
        ,
      
        movie = 
 
    GetCurrentUserUserReviewsMovie.fromJson(json['movie'])
  

        
        
       {
      
        
      
        
      
        
      
        
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
      json['id'] = 
  
    nativeToJson<String>(id)
    
;
      
    
      
        if (rating != null) {
          json['rating'] = 
  
    nativeToJson<int?>(rating)
    
;
        }
      
    
      
      json['reviewDate'] = 
  
    nativeToJson<DateTime>(reviewDate)
    
;
      
    
      
        if (reviewText != null) {
          json['reviewText'] = 
  
    nativeToJson<String?>(reviewText)
    
;
        }
      
    
      
      json['movie'] = 
  
      movie.toJson()
  
;
      
    
    return json;
  }

  GetCurrentUserUserReviews({
    
      required this.id,
    
       this.rating,
    
      required this.reviewDate,
    
       this.reviewText,
    
      required this.movie,
    
  });
}



  class GetCurrentUserUserReviewsMovie {
  
   String id;

  
   String title;

  
  
    
    
    
    GetCurrentUserUserReviewsMovie.fromJson(dynamic json):
        id = 
 
    nativeFromJson<String>(json['id'])
  

        
        ,
      
        title = 
 
    nativeFromJson<String>(json['title'])
  

        
        
       {
      
        
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
      json['id'] = 
  
    nativeToJson<String>(id)
    
;
      
    
      
      json['title'] = 
  
    nativeToJson<String>(title)
    
;
      
    
    return json;
  }

  GetCurrentUserUserReviewsMovie({
    
      required this.id,
    
      required this.title,
    
  });
}



  class GetCurrentUserUserFavoriteMovies {
  
   GetCurrentUserUserFavoriteMoviesMovie movie;

  
  
    
    
    
    GetCurrentUserUserFavoriteMovies.fromJson(dynamic json):
        movie = 
 
    GetCurrentUserUserFavoriteMoviesMovie.fromJson(json['movie'])
  

        
        
       {
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
      json['movie'] = 
  
      movie.toJson()
  
;
      
    
    return json;
  }

  GetCurrentUserUserFavoriteMovies({
    
      required this.movie,
    
  });
}



  class GetCurrentUserUserFavoriteMoviesMovie {
  
   String id;

  
   String title;

  
   String? genre;

  
   String imageUrl;

  
   int? releaseYear;

  
   double? rating;

  
   String? description;

  
   List<String>? tags;

  
   List<GetCurrentUserUserFavoriteMoviesMovieMetadata> metadata;

  
  
    
    
    
    GetCurrentUserUserFavoriteMoviesMovie.fromJson(dynamic json):
        id = 
 
    nativeFromJson<String>(json['id'])
  

        
        ,
      
        title = 
 
    nativeFromJson<String>(json['title'])
  

        
        ,
      
        genre = json['genre'] == null ? null : 
 
    nativeFromJson<String>(json['genre'])
  

        
        ,
      
        imageUrl = 
 
    nativeFromJson<String>(json['imageUrl'])
  

        
        ,
      
        releaseYear = json['releaseYear'] == null ? null : 
 
    nativeFromJson<int>(json['releaseYear'])
  

        
        ,
      
        rating = json['rating'] == null ? null : 
 
    nativeFromJson<double>(json['rating'])
  

        
        ,
      
        description = json['description'] == null ? null : 
 
    nativeFromJson<String>(json['description'])
  

        
        ,
      
        tags = json['tags'] == null ? null : 
 
    
      (json['tags'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList()
    
  

        
        ,
      
        metadata = 
 
    
      (json['metadata'] as List<dynamic>)
        .map((e) => GetCurrentUserUserFavoriteMoviesMovieMetadata.fromJson(e))
        .toList()
    
  

        
        
       {
      
        
      
        
      
        
      
        
      
        
      
        
      
        
      
        
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
      json['id'] = 
  
    nativeToJson<String>(id)
    
;
      
    
      
      json['title'] = 
  
    nativeToJson<String>(title)
    
;
      
    
      
        if (genre != null) {
          json['genre'] = 
  
    nativeToJson<String?>(genre)
    
;
        }
      
    
      
      json['imageUrl'] = 
  
    nativeToJson<String>(imageUrl)
    
;
      
    
      
        if (releaseYear != null) {
          json['releaseYear'] = 
  
    nativeToJson<int?>(releaseYear)
    
;
        }
      
    
      
        if (rating != null) {
          json['rating'] = 
  
    nativeToJson<double?>(rating)
    
;
        }
      
    
      
        if (description != null) {
          json['description'] = 
  
    nativeToJson<String?>(description)
    
;
        }
      
    
      
        if (tags != null) {
          json['tags'] = 
  
    
      tags?.map((e) => nativeToJson<String>(e)).toList()
    
  
;
        }
      
    
      
      json['metadata'] = 
  
    
      metadata.map((e) => e.toJson()).toList()
    
  
;
      
    
    return json;
  }

  GetCurrentUserUserFavoriteMoviesMovie({
    
      required this.id,
    
      required this.title,
    
       this.genre,
    
      required this.imageUrl,
    
       this.releaseYear,
    
       this.rating,
    
       this.description,
    
       this.tags,
    
      required this.metadata,
    
  });
}



  class GetCurrentUserUserFavoriteMoviesMovieMetadata {
  
   String? director;

  
  
    
    
    
    GetCurrentUserUserFavoriteMoviesMovieMetadata.fromJson(dynamic json):
        director = json['director'] == null ? null : 
 
    nativeFromJson<String>(json['director'])
  

        
        
       {
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
        if (director != null) {
          json['director'] = 
  
    nativeToJson<String?>(director)
    
;
        }
      
    
    return json;
  }

  GetCurrentUserUserFavoriteMoviesMovieMetadata({
    
       this.director,
    
  });
}



  class GetCurrentUserData {
  
   GetCurrentUserUser? user;

  
  
    
    
    
    GetCurrentUserData.fromJson(dynamic json):
        user = json['user'] == null ? null : 
 
    GetCurrentUserUser.fromJson(json['user'])
  

        
        
       {
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
        if (user != null) {
          json['user'] = 
  
      user!.toJson()
  
;
        }
      
    
    return json;
  }

  GetCurrentUserData({
    
       this.user,
    
  });
}







