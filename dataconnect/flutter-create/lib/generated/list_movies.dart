part of movies;







class ListMovies {
  String name = "ListMovies";
  ListMovies({required this.dataConnect});

  Deserializer<ListMoviesResponse> dataDeserializer = (String json)  => ListMoviesResponse.fromJson(jsonDecode(json) as Map<String, dynamic>);
  Serializer<ListMoviesVariables> varsSerializer = (ListMoviesVariables vars) => jsonEncode(vars.toJson());
  QueryRef<ListMoviesResponse, ListMoviesVariables> ref(
      {String? title,ListMoviesVariables?listMoviesVariables}) {
    ListMoviesVariables vars1=ListMoviesVariables(title: title,);
ListMoviesVariables vars = listMoviesVariables ?? vars1;
    return dataConnect.query(this.name, dataDeserializer, varsSerializer, vars);
  }
  FirebaseDataConnect dataConnect;
}


  


class ListMoviesMovies {
  
    
    
    
   late  String id;
   
  
    
    
    
   late  String title;
   
  
    
    
    
   late  int rating;
   
  
  
    ListMoviesMovies.fromJson(Map<String, dynamic> json):
          id = 
            json['id'],
        
    
          title = 
            json['title'],
        
    
          rating = 
            json['rating']
        
     {
      
         
      
         
      
         
      
    }


  // TODO(mtewani): Fix up to create a map on the fly
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
      json['id'] = 
  
    id
  
;
      
    
      
      json['title'] = 
  
    title
  
;
      
    
      
      json['rating'] = 
  
    rating
  
;
      
    
    return json;
  }

  ListMoviesMovies({
    
    required this.id,
  
    required this.title,
  
    required this.rating,
  
  }) { // TODO(mtewani): Only show this if there are optional fields.
    
      
    
      
    
      
    
  }

}




  


class ListMoviesResponse {
  
    
    
    
   late List<ListMoviesMovies> movies;
   
  
  
    ListMoviesResponse.fromJson(Map<String, dynamic> json):
          movies = 
            (json['movies'] as List<dynamic>)
              .map((e) => ListMoviesMovies.fromJson(e))
              .toList()
          
        
     {
      
         
      
    }


  // TODO(mtewani): Fix up to create a map on the fly
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
      json['movies'] = 
  
    movies.map((e) => e.toJson()).toList()
  
;
      
    
    return json;
  }

  ListMoviesResponse({
    
    required this.movies,
  
  }) { // TODO(mtewani): Only show this if there are optional fields.
    
      
    
  }

}




  


class ListMoviesVariables {
  
    
    
    
   late Optional< String> _title = Optional.optional(nativeFromJson, nativeToJson);
   
    set title(String t) {
      this._title.value = t;
    }
    String get title => this._title.value!;
   
  
  
    ListMoviesVariables.fromJson(Map<String, dynamic> json) {
      
        
          if(json.containsKey('title')) {
            _title.value = json['title'];
          }
         
      
    }


  // TODO(mtewani): Fix up to create a map on the fly
  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
        if(_title.state == OptionalState.set) {
          json['title'] = _title.toJson();
        }
      
    
    return json;
  }

  ListMoviesVariables({
    
    
      
      String? title,
    
  
  }) { // TODO(mtewani): Only show this if there are optional fields.
    
      
        
        
        this._title = Optional.optional(nativeFromJson, nativeToJson);
      
    
  }

}






