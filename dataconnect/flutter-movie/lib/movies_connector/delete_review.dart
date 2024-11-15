part of movies_connector;

class DeleteReviewVariablesBuilder {
  String movieId;

  
  FirebaseDataConnect _dataConnect;
  
  DeleteReviewVariablesBuilder(this._dataConnect, {required String this.movieId,});
  Deserializer<DeleteReviewData> dataDeserializer = (dynamic json)  => DeleteReviewData.fromJson(jsonDecode(json));
  Serializer<DeleteReviewVariables> varsSerializer = (DeleteReviewVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<DeleteReviewData, DeleteReviewVariables>> execute() {
    return this.ref().execute();
  }
  MutationRef<DeleteReviewData, DeleteReviewVariables> ref() {
    DeleteReviewVariables vars=DeleteReviewVariables(movieId: movieId,);

    return _dataConnect.mutation("DeleteReview", dataDeserializer, varsSerializer, vars);
  }
}


  class DeleteReviewReviewDelete {
  
   String userId;

  
   String movieId;

  
  
    
    
    
    DeleteReviewReviewDelete.fromJson(dynamic json):
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

  DeleteReviewReviewDelete({
    
      required this.userId,
    
      required this.movieId,
    
  });
}



  class DeleteReviewData {
  
   DeleteReviewReviewDelete? review_delete;

  
  
    
    
    
    DeleteReviewData.fromJson(dynamic json):
        review_delete = json['review_delete'] == null ? null : 
 
    DeleteReviewReviewDelete.fromJson(json['review_delete'])
  

        
        
       {
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
        if (review_delete != null) {
          json['review_delete'] = 
  
      review_delete!.toJson()
  
;
        }
      
    
    return json;
  }

  DeleteReviewData({
    
       this.review_delete,
    
  });
}



  class DeleteReviewVariables {
  
   String movieId;

  
  
    
    
     @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
    
    
    DeleteReviewVariables.fromJson(Map<String, dynamic> json):
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

  DeleteReviewVariables({
    
      required this.movieId,
    
  });
}







