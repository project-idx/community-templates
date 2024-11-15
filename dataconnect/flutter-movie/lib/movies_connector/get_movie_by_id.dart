part of movies_connector;

class GetMovieByIdVariablesBuilder {
  String id;

  
  FirebaseDataConnect _dataConnect;
  
  GetMovieByIdVariablesBuilder(this._dataConnect, {required String this.id,});
  Deserializer<GetMovieByIdData> dataDeserializer = (dynamic json)  => GetMovieByIdData.fromJson(jsonDecode(json));
  Serializer<GetMovieByIdVariables> varsSerializer = (GetMovieByIdVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetMovieByIdData, GetMovieByIdVariables>> execute() {
    return this.ref().execute();
  }
  QueryRef<GetMovieByIdData, GetMovieByIdVariables> ref() {
    GetMovieByIdVariables vars=GetMovieByIdVariables(id: id,);

    return _dataConnect.query("GetMovieById", dataDeserializer, varsSerializer, vars);
  }
}


  class GetMovieByIdMovie {
  
   String id;

  
   String title;

  
   String imageUrl;

  
   int? releaseYear;

  
   String? genre;

  
   double? rating;

  
   String? description;

  
   List<String>? tags;

  
   List<GetMovieByIdMovieMetadata> metadata;

  
   List<GetMovieByIdMovieMainActors> mainActors;

  
   List<GetMovieByIdMovieSupportingActors> supportingActors;

  
   List<GetMovieByIdMovieReviews> reviews;

  
  
    
    
    
    GetMovieByIdMovie.fromJson(dynamic json):
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
        .map((e) => GetMovieByIdMovieMetadata.fromJson(e))
        .toList()
    
  

        
        ,
      
        mainActors = 
 
    
      (json['mainActors'] as List<dynamic>)
        .map((e) => GetMovieByIdMovieMainActors.fromJson(e))
        .toList()
    
  

        
        ,
      
        supportingActors = 
 
    
      (json['supportingActors'] as List<dynamic>)
        .map((e) => GetMovieByIdMovieSupportingActors.fromJson(e))
        .toList()
    
  

        
        ,
      
        reviews = 
 
    
      (json['reviews'] as List<dynamic>)
        .map((e) => GetMovieByIdMovieReviews.fromJson(e))
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
      
    
      
      json['mainActors'] = 
  
    
      mainActors.map((e) => e.toJson()).toList()
    
  
;
      
    
      
      json['supportingActors'] = 
  
    
      supportingActors.map((e) => e.toJson()).toList()
    
  
;
      
    
      
      json['reviews'] = 
  
    
      reviews.map((e) => e.toJson()).toList()
    
  
;
      
    
    return json;
  }

  GetMovieByIdMovie({
    
      required this.id,
    
      required this.title,
    
      required this.imageUrl,
    
       this.releaseYear,
    
       this.genre,
    
       this.rating,
    
       this.description,
    
       this.tags,
    
      required this.metadata,
    
      required this.mainActors,
    
      required this.supportingActors,
    
      required this.reviews,
    
  });
}



  class GetMovieByIdMovieMetadata {
  
   String? director;

  
  
    
    
    
    GetMovieByIdMovieMetadata.fromJson(dynamic json):
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

  GetMovieByIdMovieMetadata({
    
       this.director,
    
  });
}



  class GetMovieByIdMovieMainActors {
  
   String id;

  
   String name;

  
   String imageUrl;

  
  
    
    
    
    GetMovieByIdMovieMainActors.fromJson(dynamic json):
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

  GetMovieByIdMovieMainActors({
    
      required this.id,
    
      required this.name,
    
      required this.imageUrl,
    
  });
}



  class GetMovieByIdMovieSupportingActors {
  
   String id;

  
   String name;

  
   String imageUrl;

  
  
    
    
    
    GetMovieByIdMovieSupportingActors.fromJson(dynamic json):
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

  GetMovieByIdMovieSupportingActors({
    
      required this.id,
    
      required this.name,
    
      required this.imageUrl,
    
  });
}



  class GetMovieByIdMovieReviews {
  
   String id;

  
   String? reviewText;

  
   DateTime reviewDate;

  
   int? rating;

  
   GetMovieByIdMovieReviewsUser user;

  
  
    
    
    
    GetMovieByIdMovieReviews.fromJson(dynamic json):
        id = 
 
    nativeFromJson<String>(json['id'])
  

        
        ,
      
        reviewText = json['reviewText'] == null ? null : 
 
    nativeFromJson<String>(json['reviewText'])
  

        
        ,
      
        reviewDate = 
 
    nativeFromJson<DateTime>(json['reviewDate'])
  

        
        ,
      
        rating = json['rating'] == null ? null : 
 
    nativeFromJson<int>(json['rating'])
  

        
        ,
      
        user = 
 
    GetMovieByIdMovieReviewsUser.fromJson(json['user'])
  

        
        
       {
      
        
      
        
      
        
      
        
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
      json['id'] = 
  
    nativeToJson<String>(id)
    
;
      
    
      
        if (reviewText != null) {
          json['reviewText'] = 
  
    nativeToJson<String?>(reviewText)
    
;
        }
      
    
      
      json['reviewDate'] = 
  
    nativeToJson<DateTime>(reviewDate)
    
;
      
    
      
        if (rating != null) {
          json['rating'] = 
  
    nativeToJson<int?>(rating)
    
;
        }
      
    
      
      json['user'] = 
  
      user.toJson()
  
;
      
    
    return json;
  }

  GetMovieByIdMovieReviews({
    
      required this.id,
    
       this.reviewText,
    
      required this.reviewDate,
    
       this.rating,
    
      required this.user,
    
  });
}



  class GetMovieByIdMovieReviewsUser {
  
   String id;

  
   String username;

  
  
    
    
    
    GetMovieByIdMovieReviewsUser.fromJson(dynamic json):
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

  GetMovieByIdMovieReviewsUser({
    
      required this.id,
    
      required this.username,
    
  });
}



  class GetMovieByIdData {
  
   GetMovieByIdMovie? movie;

  
  
    
    
    
    GetMovieByIdData.fromJson(dynamic json):
        movie = json['movie'] == null ? null : 
 
    GetMovieByIdMovie.fromJson(json['movie'])
  

        
        
       {
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
        if (movie != null) {
          json['movie'] = 
  
      movie!.toJson()
  
;
        }
      
    
    return json;
  }

  GetMovieByIdData({
    
       this.movie,
    
  });
}



  class GetMovieByIdVariables {
  
   String id;

  
  
    
    
     @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
    
    
    GetMovieByIdVariables.fromJson(Map<String, dynamic> json):
        id = 
 
    nativeFromJson<String>(json['id'])
  

        
        
       {
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
      json['id'] = 
  
    nativeToJson<String>(id)
    
;
      
    
    return json;
  }

  GetMovieByIdVariables({
    
      required this.id,
    
  });
}







