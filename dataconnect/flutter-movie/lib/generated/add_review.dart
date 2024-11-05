part of movies;

class AddReviewVariablesBuilder {
  String movieId;
int rating;
String reviewText;

  
  FirebaseDataConnect _dataConnect;
  
  AddReviewVariablesBuilder(this._dataConnect, {required String this.movieId,required int this.rating,required String this.reviewText,});
  Deserializer<AddReviewData> dataDeserializer = (dynamic json)  => AddReviewData.fromJson(jsonDecode(json));
  Serializer<AddReviewVariables> varsSerializer = (AddReviewVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<AddReviewData, AddReviewVariables>> execute() {
    return this.ref().execute();
  }
  MutationRef<AddReviewData, AddReviewVariables> ref() {
    AddReviewVariables vars=AddReviewVariables(movieId: movieId,rating: rating,reviewText: reviewText,);

    return _dataConnect.mutation("AddReview", dataDeserializer, varsSerializer, vars);
  }
}


  class AddReviewReviewInsert {
  
   String userId;

  
   String movieId;

  
  
    
    
    
    AddReviewReviewInsert.fromJson(dynamic json):
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

  AddReviewReviewInsert({
    
      required this.userId,
    
      required this.movieId,
    
  });
}



  class AddReviewData {
  
   AddReviewReviewInsert review_insert;

  
  
    
    
    
    AddReviewData.fromJson(dynamic json):
        review_insert = 
 
    AddReviewReviewInsert.fromJson(json['review_insert'])
  

        
        
       {
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
      json['review_insert'] = 
  
      review_insert.toJson()
  
;
      
    
    return json;
  }

  AddReviewData({
    
      required this.review_insert,
    
  });
}



  class AddReviewVariables {
  
   String movieId;

  
   int rating;

  
   String reviewText;

  
  
    
    
     @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
    
    
    AddReviewVariables.fromJson(Map<String, dynamic> json):
        movieId = 
 
    nativeFromJson<String>(json['movieId'])
  

        
        ,
      
        rating = 
 
    nativeFromJson<int>(json['rating'])
  

        
        ,
      
        reviewText = 
 
    nativeFromJson<String>(json['reviewText'])
  

        
        
       {
      
        
      
        
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
      json['movieId'] = 
  
    nativeToJson<String>(movieId)
    
;
      
    
      
      json['rating'] = 
  
    nativeToJson<int>(rating)
    
;
      
    
      
      json['reviewText'] = 
  
    nativeToJson<String>(reviewText)
    
;
      
    
    return json;
  }

  AddReviewVariables({
    
      required this.movieId,
    
      required this.rating,
    
      required this.reviewText,
    
  });
}







