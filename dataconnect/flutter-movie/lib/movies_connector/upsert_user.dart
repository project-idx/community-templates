part of movies_connector;

class UpsertUserVariablesBuilder {
  String username;
String name;

  
  FirebaseDataConnect _dataConnect;
  
  UpsertUserVariablesBuilder(this._dataConnect, {required String this.username,required String this.name,});
  Deserializer<UpsertUserData> dataDeserializer = (dynamic json)  => UpsertUserData.fromJson(jsonDecode(json));
  Serializer<UpsertUserVariables> varsSerializer = (UpsertUserVariables vars) => jsonEncode(vars.toJson());
  Future<OperationResult<UpsertUserData, UpsertUserVariables>> execute() {
    return this.ref().execute();
  }
  MutationRef<UpsertUserData, UpsertUserVariables> ref() {
    UpsertUserVariables vars=UpsertUserVariables(username: username,name: name,);

    return _dataConnect.mutation("UpsertUser", dataDeserializer, varsSerializer, vars);
  }
}


  class UpsertUserUserUpsert {
  
   String id;

  
  
    
    
    
    UpsertUserUserUpsert.fromJson(dynamic json):
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

  UpsertUserUserUpsert({
    
      required this.id,
    
  });
}



  class UpsertUserData {
  
   UpsertUserUserUpsert user_upsert;

  
  
    
    
    
    UpsertUserData.fromJson(dynamic json):
        user_upsert = 
 
    UpsertUserUserUpsert.fromJson(json['user_upsert'])
  

        
        
       {
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
      json['user_upsert'] = 
  
      user_upsert.toJson()
  
;
      
    
    return json;
  }

  UpsertUserData({
    
      required this.user_upsert,
    
  });
}



  class UpsertUserVariables {
  
   String username;

  
   String name;

  
  
    
    
     @Deprecated('fromJson is deprecated for Variable classes as they are no longer required for deserialization.')
    
    
    UpsertUserVariables.fromJson(Map<String, dynamic> json):
        username = 
 
    nativeFromJson<String>(json['username'])
  

        
        ,
      
        name = 
 
    nativeFromJson<String>(json['name'])
  

        
        
       {
      
        
      
        
      
    }


  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {};
    
      
      json['username'] = 
  
    nativeToJson<String>(username)
    
;
      
    
      
      json['name'] = 
  
    nativeToJson<String>(name)
    
;
      
    
    return json;
  }

  UpsertUserVariables({
    
      required this.username,
    
      required this.name,
    
  });
}







