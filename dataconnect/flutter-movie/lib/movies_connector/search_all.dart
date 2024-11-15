part of movies_connector;

class SearchAllVariablesBuilder {
  Optional<String> _input = Optional.optional(nativeFromJson, nativeToJson);
int minYear;
int maxYear;
double minRating;
double maxRating;
String genre;

  
  FirebaseDataConnect _dataConnect;
  SearchAllVariablesBuilder input(String? t) {
this._input.value = t;
return this;
}

  SearchAllVariablesBuilder(this._dataConnect, {required int this.minYear,required int this.maxYear,required double this.minRating,required double this.maxRating,required String this.genre,});
  Deserializer<SearchAllData> dataDeserializer = (dynamic json)  => SearchAllData.fromJson(jsonDecode(json));
  Serializer<SearchAllVariables> varsSerializer = (SearchAllVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<SearchAllData, SearchAllVariables>> execute() {
    return this.ref().execute();
  }
  QueryRef<SearchAllData, SearchAllVariables> ref() {
    SearchAllVariables vars=SearchAllVariables(input: _input,minYear: minYear,maxYear: maxYear,minRating: minRating,maxRating: maxRating,genre: genre,);

    return _dataConnect.query("SearchAll", dataDeserializer, varsSerializer, vars);
  }
}


  class SearchAllMoviesMatchingTitle {
  
   String id;

  
   String title;

  
   String? genre;

  
   double? rating;

  
   String imageUrl;

  
  
    
    
    
    SearchAllMoviesMatchingTitle.fromJson(dynamic json):
        id = 
 
    nativeFromJson<String>(json['id'])
  

        
        ,
      
        title = 
 
    nativeFromJson<String>(json['title'])
  

        
        ,
      
        genre = json['genre'] == null ? null : 
 
    nativeFromJson<String>(json['genre'])
  

        
        ,
      
        rating = json['rating'] == null ? null : 
 
    nativeFromJson<double>(json['rating'])
  

        
        ,
      
        imageUrl = 
 
    nativeFromJson<String>(json['imageUrl'])
  

        
        
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
      
    
      
        if (rating != null) {
          json['rating'] = 
  
    nativeToJson<double?>(rating)
    
;
        }
      
    
      
      json['imageUrl'] = 
  
    nativeToJson<String>(imageUrl)
    
;
      
    
    return json;
  }

  SearchAllMoviesMatchingTitle({
    
      required this.id,
    
      required this.title,
    
       this.genre,
    
       this.rating,
    
      required this.imageUrl,
    
  });
}



  class SearchAllMoviesMatchingDescription {
  
   String id;

  
   String title;

  
   String? genre;

  
   double? rating;

  
   String imageUrl;

  
  
    
    
    
    SearchAllMoviesMatchingDescription.fromJson(dynamic json):
        id = 
 
    nativeFromJson<String>(json['id'])
  

        
        ,
      
        title = 
 
    nativeFromJson<String>(json['title'])
  

        
        ,
      
        genre = json['genre'] == null ? null : 
 
    nativeFromJson<String>(json['genre'])
  

        
        ,
      
        rating = json['rating'] == null ? null : 
 
    nativeFromJson<double>(json['rating'])
  

        
        ,
      
        imageUrl = 
 
    nativeFromJson<String>(json['imageUrl'])
  

        
        
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
      
    
      
        if (rating != null) {
          json['rating'] = 
  
    nativeToJson<double?>(rating)
    
;
        }
      
    
      
      json['imageUrl'] = 
  
    nativeToJson<String>(imageUrl)
    
;
      
    
    return json;
  }

  SearchAllMoviesMatchingDescription({
    
      required this.id,
    
      required this.title,
    
       this.genre,
    
       this.rating,
    
      required this.imageUrl,
    
  });
}



  class SearchAllActorsMatchingName {
  
   String id;

  
   String name;

  
   String imageUrl;

  
  
    
    
    
    SearchAllActorsMatchingName.fromJson(dynamic json):
        id = 
 
    nativeFromJson<String>(json['id'])
  

        
        ,
      
        name = 
 
    nativeFromJson<String>(json['name'])
  

        
        ,
      
        imageUrl = 
 
    nativeFromJson<String>(json['imageUrl'])
  

        
        
       {
      
        
      
        
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
      json['id'] = 
  
    nativeToJson<String>(id)
    
;
      
    
      
      json['name'] = 
  
    nativeToJson<String>(name)
    
;
      
    
      
      json['imageUrl'] = 
  
    nativeToJson<String>(imageUrl)
    
;
      
    
    return json;
  }

  SearchAllActorsMatchingName({
    
      required this.id,
    
      required this.name,
    
      required this.imageUrl,
    
  });
}



  class SearchAllReviewsMatchingText {
  
   String id;

  
   int? rating;

  
   String? reviewText;

  
   DateTime reviewDate;

  
   SearchAllReviewsMatchingTextMovie movie;

  
   SearchAllReviewsMatchingTextUser user;

  
  
    
    
    
    SearchAllReviewsMatchingText.fromJson(dynamic json):
        id = 
 
    nativeFromJson<String>(json['id'])
  

        
        ,
      
        rating = json['rating'] == null ? null : 
 
    nativeFromJson<int>(json['rating'])
  

        
        ,
      
        reviewText = json['reviewText'] == null ? null : 
 
    nativeFromJson<String>(json['reviewText'])
  

        
        ,
      
        reviewDate = 
 
    nativeFromJson<DateTime>(json['reviewDate'])
  

        
        ,
      
        movie = 
 
    SearchAllReviewsMatchingTextMovie.fromJson(json['movie'])
  

        
        ,
      
        user = 
 
    SearchAllReviewsMatchingTextUser.fromJson(json['user'])
  

        
        
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
      
    
      
        if (reviewText != null) {
          json['reviewText'] = 
  
    nativeToJson<String?>(reviewText)
    
;
        }
      
    
      
      json['reviewDate'] = 
  
    nativeToJson<DateTime>(reviewDate)
    
;
      
    
      
      json['movie'] = 
  
      movie.toJson()
  
;
      
    
      
      json['user'] = 
  
      user.toJson()
  
;
      
    
    return json;
  }

  SearchAllReviewsMatchingText({
    
      required this.id,
    
       this.rating,
    
       this.reviewText,
    
      required this.reviewDate,
    
      required this.movie,
    
      required this.user,
    
  });
}



  class SearchAllReviewsMatchingTextMovie {
  
   String id;

  
   String title;

  
  
    
    
    
    SearchAllReviewsMatchingTextMovie.fromJson(dynamic json):
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

  SearchAllReviewsMatchingTextMovie({
    
      required this.id,
    
      required this.title,
    
  });
}



  class SearchAllReviewsMatchingTextUser {
  
   String id;

  
   String username;

  
  
    
    
    
    SearchAllReviewsMatchingTextUser.fromJson(dynamic json):
        id = 
 
    nativeFromJson<String>(json['id'])
  

        
        ,
      
        username = 
 
    nativeFromJson<String>(json['username'])
  

        
        
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
      
    
    return json;
  }

  SearchAllReviewsMatchingTextUser({
    
      required this.id,
    
      required this.username,
    
  });
}



  class SearchAllData {
  
   List<SearchAllMoviesMatchingTitle> moviesMatchingTitle;

  
   List<SearchAllMoviesMatchingDescription> moviesMatchingDescription;

  
   List<SearchAllActorsMatchingName> actorsMatchingName;

  
   List<SearchAllReviewsMatchingText> reviewsMatchingText;

  
  
    
    
    
    SearchAllData.fromJson(dynamic json):
        moviesMatchingTitle = 
 
    
      (json['moviesMatchingTitle'] as List<dynamic>)
        .map((e) => SearchAllMoviesMatchingTitle.fromJson(e))
        .toList()
    
  

        
        ,
      
        moviesMatchingDescription = 
 
    
      (json['moviesMatchingDescription'] as List<dynamic>)
        .map((e) => SearchAllMoviesMatchingDescription.fromJson(e))
        .toList()
    
  

        
        ,
      
        actorsMatchingName = 
 
    
      (json['actorsMatchingName'] as List<dynamic>)
        .map((e) => SearchAllActorsMatchingName.fromJson(e))
        .toList()
    
  

        
        ,
      
        reviewsMatchingText = 
 
    
      (json['reviewsMatchingText'] as List<dynamic>)
        .map((e) => SearchAllReviewsMatchingText.fromJson(e))
        .toList()
    
  

        
        
       {
      
        
      
        
      
        
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
      json['moviesMatchingTitle'] = 
  
    
      moviesMatchingTitle.map((e) => e.toJson()).toList()
    
  
;
      
    
      
      json['moviesMatchingDescription'] = 
  
    
      moviesMatchingDescription.map((e) => e.toJson()).toList()
    
  
;
      
    
      
      json['actorsMatchingName'] = 
  
    
      actorsMatchingName.map((e) => e.toJson()).toList()
    
  
;
      
    
      
      json['reviewsMatchingText'] = 
  
    
      reviewsMatchingText.map((e) => e.toJson()).toList()
    
  
;
      
    
    return json;
  }

  SearchAllData({
    
      required this.moviesMatchingTitle,
    
      required this.moviesMatchingDescription,
    
      required this.actorsMatchingName,
    
      required this.reviewsMatchingText,
    
  });
}



  class SearchAllVariables {
  
   late Optional<String>input;

  
   int minYear;

  
   int maxYear;

  
   double minRating;

  
   double maxRating;

  
   String genre;

  
  
    
    
     @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
    
    
    SearchAllVariables.fromJson(Map<String, dynamic> json):
        minYear = 
 
    nativeFromJson<int>(json['minYear'])
  

        
        ,
      
        maxYear = 
 
    nativeFromJson<int>(json['maxYear'])
  

        
        ,
      
        minRating = 
 
    nativeFromJson<double>(json['minRating'])
  

        
        ,
      
        maxRating = 
 
    nativeFromJson<double>(json['maxRating'])
  

        
        ,
      
        genre = 
 
    nativeFromJson<String>(json['genre'])
  

        
        
       {
      
        
          input = Optional.optional(nativeFromJson, nativeToJson);
          input.value = json['input'] == null ? null : 
 
    nativeFromJson<String>(json['input'])
  
;
        
      
        
      
        
      
        
      
        
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
        if(input.state == OptionalState.set) {
          json['input'] = input.toJson();
        }
     
    
      
      json['minYear'] = 
  
    nativeToJson<int>(minYear)
    
;
      
    
      
      json['maxYear'] = 
  
    nativeToJson<int>(maxYear)
    
;
      
    
      
      json['minRating'] = 
  
    nativeToJson<double>(minRating)
    
;
      
    
      
      json['maxRating'] = 
  
    nativeToJson<double>(maxRating)
    
;
      
    
      
      json['genre'] = 
  
    nativeToJson<String>(genre)
    
;
      
    
    return json;
  }

  SearchAllVariables({
    
      required this.input,
    
      required this.minYear,
    
      required this.maxYear,
    
      required this.minRating,
    
      required this.maxRating,
    
      required this.genre,
    
  });
}







