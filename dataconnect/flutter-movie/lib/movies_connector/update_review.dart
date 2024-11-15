part of movies_connector;

class UpdateReviewVariablesBuilder {
  String movieId;
int rating;
String reviewText;

  
  FirebaseDataConnect _dataConnect;
  
  UpdateReviewVariablesBuilder(this._dataConnect, {required String this.movieId,required int this.rating,required String this.reviewText,});
  Deserializer<UpdateReviewData> dataDeserializer = (dynamic json)  => UpdateReviewData.fromJson(jsonDecode(json));
  Serializer<UpdateReviewVariables> varsSerializer = (UpdateReviewVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpdateReviewData, UpdateReviewVariables>> execute() {
    return this.ref().execute();
  }
  MutationRef<UpdateReviewData, UpdateReviewVariables> ref() {
    UpdateReviewVariables vars=UpdateReviewVariables(movieId: movieId,rating: rating,reviewText: reviewText,);

    return _dataConnect.mutation("UpdateReview", dataDeserializer, varsSerializer, vars);
  }
}


  class UpdateReviewReviewUpdate {
  
   String userId;

  
   String movieId;

  
  
    
    
    
    UpdateReviewReviewUpdate.fromJson(dynamic json):
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

  UpdateReviewReviewUpdate({
    
      required this.userId,
    
      required this.movieId,
    
  });
}



  class UpdateReviewData {
  
   UpdateReviewReviewUpdate? review_update;

  
  
    
    
    
    UpdateReviewData.fromJson(dynamic json):
        review_update = json['review_update'] == null ? null : 
 
    UpdateReviewReviewUpdate.fromJson(json['review_update'])
  

        
        
       {
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
        if (review_update != null) {
          json['review_update'] = 
  
      review_update!.toJson()
  
;
        }
      
    
    return json;
  }

  UpdateReviewData({
    
       this.review_update,
    
  });
}



  class UpdateReviewVariables {
  
   String movieId;

  
   int rating;

  
   String reviewText;

  
  
    
    
     @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
    
    
    UpdateReviewVariables.fromJson(Map<String, dynamic> json):
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

  UpdateReviewVariables({
    
      required this.movieId,
    
      required this.rating,
    
      required this.reviewText,
    
  });
}







