library movies;
import 'package:firebase_data_connect/firebase_data_connect.dart';
import 'dart:convert';

part 'list_movies.dart';



class MoviesConnector {
  
  ListMovies get listMovies {
    return ListMovies(dataConnect: dataConnect);
  }
  

  static ConnectorConfig connectorConfig = ConnectorConfig(
    'us-west2',
    'movies',
    'dataconnect',
  );

  MoviesConnector({required this.dataConnect});
  static MoviesConnector get instance {
    return MoviesConnector(
        dataConnect:
            FirebaseDataConnect.instanceFor(connectorConfig: connectorConfig));
  }

  FirebaseDataConnect dataConnect;
}

