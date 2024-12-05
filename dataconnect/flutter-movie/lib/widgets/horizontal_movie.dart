import 'package:dataconnect/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HorizontalMovie extends StatelessWidget {
  const HorizontalMovie({super.key, required this.movie});
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Image.network(movie.imageUrl),
            onTap: () {
              context.push("/movies/${movie.id}");
            },
            title: Text(movie.title),
            subtitle: movie.description != null
                ? Text(movie.description!)
                : const Text(''),
          ),
        ],
      ),
    );
  }
}
