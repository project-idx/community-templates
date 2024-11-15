part of movies_connector;

class ListMoviesByGenreVariablesBuilder {
  String genre;
Optional<OrderDirection> _orderByRating = Optional.optional(orderDirectionDeserializer, enumSerializer);
Optional<OrderDirection> _orderByReleaseYear = Optional.optional(orderDirectionDeserializer, enumSerializer);
Optional<int> _limit = Optional.optional(nativeFromJson, nativeToJson);

  
  FirebaseDataConnect _dataConnect;
  ListMoviesByGenreVariablesBuilder orderByRating(OrderDirection? t) {
this._orderByRating.value = t;
return this;
}
ListMoviesByGenreVariablesBuilder orderByReleaseYear(OrderDirection? t) {
this._orderByReleaseYear.value = t;
return this;
}
ListMoviesByGenreVariablesBuilder limit(int? t) {
this._limit.value = t;
return this;
}

  ListMoviesByGenreVariablesBuilder(this._dataConnect, {required String this.genre,});
  Deserializer<ListMoviesByGenreData> dataDeserializer = (dynamic json)  => ListMoviesByGenreData.fromJson(jsonDecode(json));
  Serializer<ListMoviesByGenreVariables> varsSerializer = (ListMoviesByGenreVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListMoviesByGenreData, ListMoviesByGenreVariables>> execute() {
    return this.ref().execute();
  }
  QueryRef<ListMoviesByGenreData, ListMoviesByGenreVariables> ref() {
    ListMoviesByGenreVariables vars=ListMoviesByGenreVariables(genre: genre,orderByRating: _orderByRating,orderByReleaseYear: _orderByReleaseYear,limit: _limit,);

    return _dataConnect.query("ListMoviesByGenre", dataDeserializer, varsSerializer, vars);
  }
}


  class ListMoviesByGenreMovies {
  
   String id;

  
   String title;

  
   String imageUrl;

  
   int? releaseYear;

  
   String? genre;

  
   double? rating;

  
   List<String>? tags;

  
   String? description;

  
  
    
    
    
    ListMoviesByGenreMovies.fromJson(dynamic json):
        id = 
 
    nativeFromJson<String>(json['id'])
  

        
        ,
      
        title = 
 
    nativeFromJson<String>(json['title'])
  

        
        ,
      
        imageUrl = 
 
    nativeFromJson<String>(json['imageUrl'])
  

        
        ,
      
        releaseYear = json['releaseYear'] == null ? null : 
 
    nativeFromJson<int>(json['releaseYear'])
  

        
        ,
      
        genre = json['genre'] == null ? null : 
 
    nativeFromJson<String>(json['genre'])
  

        
        ,
      
        rating = json['rating'] == null ? null : 
 
    nativeFromJson<double>(json['rating'])
  

        
        ,
      
        tags = json['tags'] == null ? null : 
 
    
      (json['tags'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList()
    
  

        
        ,
      
        description = json['description'] == null ? null : 
 
    nativeFromJson<String>(json['description'])
  

        
        
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
      
    
      
      json['imageUrl'] = 
  
    nativeToJson<String>(imageUrl)
    
;
      
    
      
        if (releaseYear != null) {
          json['releaseYear'] = 
  
    nativeToJson<int?>(releaseYear)
    
;
        }
      
    
      
        if (genre != null) {
          json['genre'] = 
  
    nativeToJson<String?>(genre)
    
;
        }
      
    
      
        if (rating != null) {
          json['rating'] = 
  
    nativeToJson<double?>(rating)
    
;
        }
      
    
      
        if (tags != null) {
          json['tags'] = 
  
    
      tags?.map((e) => nativeToJson<String>(e)).toList()
    
  
;
        }
      
    
      
        if (description != null) {
          json['description'] = 
  
    nativeToJson<String?>(description)
    
;
        }
      
    
    return json;
  }

  ListMoviesByGenreMovies({
    
      required this.id,
    
      required this.title,
    
      required this.imageUrl,
    
       this.releaseYear,
    
       this.genre,
    
       this.rating,
    
       this.tags,
    
       this.description,
    
  });
}



  class ListMoviesByGenreData {
  
   List<ListMoviesByGenreMovies> movies;

  
  
    
    
    
    ListMoviesByGenreData.fromJson(dynamic json):
        movies = 
 
    
      (json['movies'] as List<dynamic>)
        .map((e) => ListMoviesByGenreMovies.fromJson(e))
        .toList()
    
  

        
        
       {
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
      json['movies'] = 
  
    
      movies.map((e) => e.toJson()).toList()
    
  
;
      
    
    return json;
  }

  ListMoviesByGenreData({
    
      required this.movies,
    
  });
}



  class ListMoviesByGenreVariables {
  
   String genre;

  
   late Optional<OrderDirection>orderByRating;

  
   late Optional<OrderDirection>orderByReleaseYear;

  
   late Optional<int>limit;

  
  
    
    
     @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
    
    
    ListMoviesByGenreVariables.fromJson(Map<String, dynamic> json):
        genre = 
 
    nativeFromJson<String>(json['genre'])
  

        
        
       {
      
        
      
        
          orderByRating = Optional.optional(orderDirectionDeserializer, enumSerializer);
          orderByRating.value = json['orderByRating'] == null ? null : 
 
    OrderDirection.values.byName(json['orderByRating'])
  
;
        
      
        
          orderByReleaseYear = Optional.optional(orderDirectionDeserializer, enumSerializer);
          orderByReleaseYear.value = json['orderByReleaseYear'] == null ? null : 
 
    OrderDirection.values.byName(json['orderByReleaseYear'])
  
;
        
      
        
          limit = Optional.optional(nativeFromJson, nativeToJson);
          limit.value = json['limit'] == null ? null : 
 
    nativeFromJson<int>(json['limit'])
  
;
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
      json['genre'] = 
  
    nativeToJson<String>(genre)
    
;
      
    
      
        if(orderByRating.state == OptionalState.set) {
          json['orderByRating'] = orderByRating.toJson();
        }
     
    
      
        if(orderByReleaseYear.state == OptionalState.set) {
          json['orderByReleaseYear'] = orderByReleaseYear.toJson();
        }
     
    
      
        if(limit.state == OptionalState.set) {
          json['limit'] = limit.toJson();
        }
     
    
    return json;
  }

  ListMoviesByGenreVariables({
    
      required this.genre,
    
      required this.orderByRating,
    
      required this.orderByReleaseYear,
    
      required this.limit,
    
  });
}







