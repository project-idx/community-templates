part of movies_connector;

class ListGenresVariablesBuilder {
  
  
  FirebaseDataConnect _dataConnect;
  
  ListGenresVariablesBuilder(this._dataConnect, );
  Deserializer<ListGenresData> dataDeserializer = (dynamic json)  => ListGenresData.fromJson(jsonDecode(json));
  
  Future<QueryResult<ListGenresData, void>> execute() {
    return this.ref().execute();
  }
  QueryRef<ListGenresData, void> ref() {
    
    return _dataConnect.query("ListGenres", dataDeserializer, emptySerializer, null);
  }
}


  class ListGenresGenres {
  
   String? genre;

  
  
    
    
    
    ListGenresGenres.fromJson(dynamic json):
        genre = json['genre'] == null ? null : 
 
    nativeFromJson<String>(json['genre'])
  

        
        
       {
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
        if (genre != null) {
          json['genre'] = 
  
    nativeToJson<String?>(genre)
    
;
        }
      
    
    return json;
  }

  ListGenresGenres({
    
       this.genre,
    
  });
}



  class ListGenresData {
  
   List<ListGenresGenres> genres;

  
  
    
    
    
    ListGenresData.fromJson(dynamic json):
        genres = 
 
    
      (json['genres'] as List<dynamic>)
        .map((e) => ListGenresGenres.fromJson(e))
        .toList()
    
  

        
        
       {
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
      json['genres'] = 
  
    
      genres.map((e) => e.toJson()).toList()
    
  
;
      
    
    return json;
  }

  ListGenresData({
    
      required this.genres,
    
  });
}







