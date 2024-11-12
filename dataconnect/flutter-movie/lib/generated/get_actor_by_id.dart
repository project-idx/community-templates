part of movies;

class GetActorByIdVariablesBuilder {
  String id;

  
  FirebaseDataConnect _dataConnect;
  
  GetActorByIdVariablesBuilder(this._dataConnect, {required String this.id,});
  Deserializer<GetActorByIdData> dataDeserializer = (dynamic json)  => GetActorByIdData.fromJson(jsonDecode(json));
  Serializer<GetActorByIdVariables> varsSerializer = (GetActorByIdVariables vars) => jsonEncode(vars.toJson());
  Future<QueryResult<GetActorByIdData, GetActorByIdVariables>> execute() {
    return this.ref().execute();
  }
  QueryRef<GetActorByIdData, GetActorByIdVariables> ref() {
    GetActorByIdVariables vars=GetActorByIdVariables(id: id,);

    return _dataConnect.query("GetActorById", dataDeserializer, varsSerializer, vars);
  }
}


  class GetActorByIdActor {
  
   String id;

  
   String name;

  
   String imageUrl;

  
   List<GetActorByIdActorMainActors> mainActors;

  
   List<GetActorByIdActorSupportingActors> supportingActors;

  
  
    
    
    
    GetActorByIdActor.fromJson(dynamic json):
        id = 
 
    nativeFromJson<String>(json['id'])
  

        
        ,
      
        name = 
 
    nativeFromJson<String>(json['name'])
  

        
        ,
      
        imageUrl = 
 
    nativeFromJson<String>(json['imageUrl'])
  

        
        ,
      
        mainActors = 
 
    
      (json['mainActors'] as List<dynamic>)
        .map((e) => GetActorByIdActorMainActors.fromJson(e))
        .toList()
    
  

        
        ,
      
        supportingActors = 
 
    
      (json['supportingActors'] as List<dynamic>)
        .map((e) => GetActorByIdActorSupportingActors.fromJson(e))
        .toList()
    
  

        
        
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
      
    
      
      json['mainActors'] = 
  
    
      mainActors.map((e) => e.toJson()).toList()
    
  
;
      
    
      
      json['supportingActors'] = 
  
    
      supportingActors.map((e) => e.toJson()).toList()
    
  
;
      
    
    return json;
  }

  GetActorByIdActor({
    
      required this.id,
    
      required this.name,
    
      required this.imageUrl,
    
      required this.mainActors,
    
      required this.supportingActors,
    
  });
}



  class GetActorByIdActorMainActors {
  
   String id;

  
   String title;

  
   String? genre;

  
   List<String>? tags;

  
   String imageUrl;

  
  
    
    
    
    GetActorByIdActorMainActors.fromJson(dynamic json):
        id = 
 
    nativeFromJson<String>(json['id'])
  

        
        ,
      
        title = 
 
    nativeFromJson<String>(json['title'])
  

        
        ,
      
        genre = json['genre'] == null ? null : 
 
    nativeFromJson<String>(json['genre'])
  

        
        ,
      
        tags = json['tags'] == null ? null : 
 
    
      (json['tags'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList()
    
  

        
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
      
    
      
        if (tags != null) {
          json['tags'] = 
  
    
      tags?.map((e) => nativeToJson<String>(e)).toList()
    
  
;
        }
      
    
      
      json['imageUrl'] = 
  
    nativeToJson<String>(imageUrl)
    
;
      
    
    return json;
  }

  GetActorByIdActorMainActors({
    
      required this.id,
    
      required this.title,
    
       this.genre,
    
       this.tags,
    
      required this.imageUrl,
    
  });
}



  class GetActorByIdActorSupportingActors {
  
   String id;

  
   String title;

  
   String? genre;

  
   List<String>? tags;

  
   String imageUrl;

  
  
    
    
    
    GetActorByIdActorSupportingActors.fromJson(dynamic json):
        id = 
 
    nativeFromJson<String>(json['id'])
  

        
        ,
      
        title = 
 
    nativeFromJson<String>(json['title'])
  

        
        ,
      
        genre = json['genre'] == null ? null : 
 
    nativeFromJson<String>(json['genre'])
  

        
        ,
      
        tags = json['tags'] == null ? null : 
 
    
      (json['tags'] as List<dynamic>)
        .map((e) => nativeFromJson<String>(e))
        .toList()
    
  

        
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
      
    
      
        if (tags != null) {
          json['tags'] = 
  
    
      tags?.map((e) => nativeToJson<String>(e)).toList()
    
  
;
        }
      
    
      
      json['imageUrl'] = 
  
    nativeToJson<String>(imageUrl)
    
;
      
    
    return json;
  }

  GetActorByIdActorSupportingActors({
    
      required this.id,
    
      required this.title,
    
       this.genre,
    
       this.tags,
    
      required this.imageUrl,
    
  });
}



  class GetActorByIdData {
  
   GetActorByIdActor? actor;

  
  
    
    
    
    GetActorByIdData.fromJson(dynamic json):
        actor = json['actor'] == null ? null : 
 
    GetActorByIdActor.fromJson(json['actor'])
  

        
        
       {
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
        if (actor != null) {
          json['actor'] = 
  
      actor!.toJson()
  
;
        }
      
    
    return json;
  }

  GetActorByIdData({
    
       this.actor,
    
  });
}



  class GetActorByIdVariables {
  
   String id;

  
  
    
    
     @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
    
    
    GetActorByIdVariables.fromJson(Map<String, dynamic> json):
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

  GetActorByIdVariables({
    
      required this.id,
    
  });
}







