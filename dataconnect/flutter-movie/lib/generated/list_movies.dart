part of movies;

class ListMoviesVariablesBuilder {
  Optional<OrderDirection> _orderByRating = Optional.optional(orderDirectionDeserializer, enumSerializer);
Optional<OrderDirection> _orderByReleaseYear = Optional.optional(orderDirectionDeserializer, enumSerializer);
Optional<int> _limit = Optional.optional(nativeFromJson, nativeToJson);

  
  FirebaseDataConnect _dataConnect;
  ListMoviesVariablesBuilder orderByRating(OrderDirection? t) {
this._orderByRating.value = t;
return this;
}
ListMoviesVariablesBuilder orderByReleaseYear(OrderDirection? t) {
this._orderByReleaseYear.value = t;
return this;
}
ListMoviesVariablesBuilder limit(int? t) {
this._limit.value = t;
return this;
}

  ListMoviesVariablesBuilder(this._dataConnect, );
  Deserializer<ListMoviesData> dataDeserializer = (dynamic json)  => ListMoviesData.fromJson(jsonDecode(json));
  Serializer<ListMoviesVariables> varsSerializer = (ListMoviesVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<ListMoviesData, ListMoviesVariables>> execute() {
    return this.ref().execute();
  }
  QueryRef<ListMoviesData, ListMoviesVariables> ref() {
    ListMoviesVariables vars=ListMoviesVariables(orderByRating: _orderByRating,orderByReleaseYear: _orderByReleaseYear,limit: _limit,);

    return _dataConnect.query("ListMovies", dataDeserializer, varsSerializer, vars);
  }
}


  class ListMoviesMovies {
  
   String id;

  
   String title;

  
   String imageUrl;

  
   int? releaseYear;

  
   String? genre;

  
   double? rating;

  
   List<String>? tags;

  
   String? description;

  
  
    
    
    
    ListMoviesMovies.fromJson(dynamic json):
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

  ListMoviesMovies({
    
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



  class ListMoviesData {
  
   List<ListMoviesMovies> movies;

  
  
    
    
    
    ListMoviesData.fromJson(dynamic json):
        movies = 
 
    
      (json['movies'] as List<dynamic>)
        .map((e) => ListMoviesMovies.fromJson(e))
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

  ListMoviesData({
    
      required this.movies,
    
  });
}



  class ListMoviesVariables {
  
   late Optional<OrderDirection>orderByRating;

  
   late Optional<OrderDirection>orderByReleaseYear;

  
   late Optional<int>limit;

  
  
    
    
     @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
    
    
    ListMoviesVariables.fromJson(Map<String, dynamic> json) {
      
        
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

  ListMoviesVariables({
    
      required this.orderByRating,
    
      required this.orderByReleaseYear,
    
      required this.limit,
    
  });
}







